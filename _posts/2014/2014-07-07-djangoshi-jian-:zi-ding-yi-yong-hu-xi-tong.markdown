---
layout: post
title: "Django实践：自定义用户系统"
date: 2014-07-07 15:01:15 +0800
comments: true
categories: [Django, Python]
---


##扩展Django的用户系统有几个方法：

+ 1.在自定义Model中使用OneToOneField的方式来扩展，实现一个User Profile。
这种方式在1.5之前是推荐的，在User也有一个默认的get_profile方法来获取这个profile。
这种方式的好处是1.5以前的版本默认支持，并且对Django的影响最小，坏处主要是获取资料的时候需要一次join表。
示例代码如下：

      class UserProfile(models.Model):
          user = models.OneToOneField('auth.User')
          bio = models.TextField()

+ 2.从Django的User派生或者重写，这样要比较小心地满足Django一些耦合的地方，才能利用起Django的用户认证
和管理。这种方式不推荐，维护起来很麻烦，也容易产生冲突。

+ 3.在Django1.5开始加强了用户自定义的功能，从AbstractBaseUser, PermissionsMixin开始派生出一个自定用户Model，
并且实现自定义的BaseUserManager就能够使用Django来创建用户。为了在Django管理界面管理自定义的用户，还需要实现自定义的UserAdmin。
下面是例子：
*常用的做法应该是放到单独的用户app譬如user或者account下面。*

>在user/models.py放以下代码：

      from django.db import models
      from django.contrib.auth.models import BaseUserManager, AbstractBaseUser, PermissionsMixin

      class MyUserManager(BaseUserManager):
          def create_user(self, nick_name, email, password, **extra_fields):
          if not email:
            raise ValueError('Users must have an email address')

          user = self.model(
              nick_name=nick_name,
              email=MyUserManager.normalize_email(email),
              is_staff=False,
              is_active=True,
              is_superuser=False,
              **extra_fields
          )
          user.set_password(password)
          user.save(using=self._db)
          return user

          def create_superuser(self, nick_name, email, password, **extra_fields):
              user = self.create_user(nick_name,
                  email,
                  password,
                  **extra_fields
              )
              user.is_staff=True
              user.is_active=True
              user.is_superuser = True
              user.save(using=self._db)
              return user

      # 在settings里面指定这个User类为AUTH_USER_MODEL
      class User(AbstractBaseUser, PermissionsMixin):
          nick_name = models.CharField(max_length=100, unique=True, db_index=True)
          pwd = models.CharField(max_length=128)
          mobilebind = models.IntegerField(default=0)
          phone = models.CharField(max_length=20)
          say = models.CharField(max_length=255)
          email = models.EmailField(verbose_name='email address',max_length=254)

          is_staff = models.BooleanField('staff status', default=False,
              help_text='flag for log into admin site.')
          is_active = models.BooleanField('active', default=True)

          USERNAME_FIELD = 'nick_name'
          REQUIRED_FIELDS = ['email']
          objects = MyUserManager()     # 在这里关联自定义的UserManager

          def get_full_name(self):
              return self.nick_name

          def get_short_name(self):
              return self.nick_name

          def __unicode__(self):
              return self.nick_name
          #def is_authenticated(self):  
          #    return True  

          '''
          # 这个函数可以实现自定义的用户密码检验，除非你想跳过Django的才实现。
          def check_password(self, password):  
              if self.hashed_password(password) == self.pwd:  
                  return True
              print 'debug: password(%s), hashed %s, self.pwd %s' % (password, self.hashed_password(password), self.pwd)
              return False
          '''

          '''
          # 这里可以实现自己的密码管理
          def set_password(self, raw_password):
              print 'set_password called'
              self.pwd = self.my_hashed_pwd(raw_password)
              super(User, self).set_password(raw_password)
          '''
          # 如果要自定义表名的话
          class Meta:  
              db_table = "myuser"

      # 其他要用到user的地方直接用这个自定义的user就好了
      class FriendRelation(models.Model):
          user = models.ForeignKey(User)
          friend = models.IntegerField()

>然后在project的settings.py里面加入：

      AUTH_USER_MODEL = 'user.User'

>接着在user/admin.py(没有就创建)中加入以下代码：

      from django import forms
      from django.contrib import admin
      from django.contrib.auth.models import Group
      from django.contrib.auth.admin import UserAdmin
      from django.contrib.auth.forms import ReadOnlyPasswordHashField
      from user.models import User  # 这里改成对应的包

      class UserCreationForm(forms.ModelForm):
          """A form for creating new users. Includes all the required
          fields, plus a repeated password."""
          password1 = forms.CharField(label='Password', widget=forms.PasswordInput)
          password2 = forms.CharField(label='Password confirmation', widget=forms.PasswordInput)

          class Meta:
              model = User
              fields = ('nick_name', 'pwd', 'email', 'mobilebind', 'say')  # 改成想要的字段

          def clean_password2(self):
              # Check that the two password entries match
              password1 = self.cleaned_data.get("password1")
              password2 = self.cleaned_data.get("password2")
              if password1 and password2 and password1 != password2:
                  raise forms.ValidationError("Passwords don't match")
              return password2

          def save(self, commit=True):
              # Save the provided password in hashed format
              user = super(UserCreationForm, self).save(commit=False)
              user.set_password(self.cleaned_data["password1"])
              if commit:
                  user.save()
              return user


      class UserChangeForm(forms.ModelForm):
          """A form for updating users. Includes all the fields on
          the user, but replaces the password field with admin's
          password hash display field.
          """
          password = ReadOnlyPasswordHashField()

          class Meta:
              model = User

          def clean_password(self):
              # Regardless of what the user provides, return the initial value.
              # This is done here, rather than on the field, because the
              # field does not have access to the initial value
              return self.initial["password"]


      class MyUserAdmin(UserAdmin):
          # The forms to add and change user instances
          form = UserChangeForm
          add_form = UserCreationForm

          # The fields to be used in displaying the User model.
          # These override the definitions on the base UserAdmin
          # that reference specific fields on auth.User.
          list_display = ('nick_name', 'email', 'is_superuser')
          list_filter = ('is_superuser',)
          fieldsets = (
              (None, {'fields': ('nick_name', 'email', 'password')}),
              ('Personal info', {'fields': ('pwd',)}),
              ('Permissions', {'fields': ('is_superuser',)}),
              #('Important dates', {'fields': ('last_login',)}),
          )
          add_fieldsets = (
              (None, {
                  'classes': ('wide',),
                  'fields': ('nick_name', 'pwd', 'email', 'password1', 'password2')}
              ),
          )
          search_fields = ('nick_name', 'email',)
          ordering = ('nick_name', 'email',)
          filter_horizontal = ()

      # Now register the new UserAdmin...
      admin.site.register(User, MyUserAdmin)
      # ... and, since we're not using Django's builtin permissions,
      # unregister the Group model from admin.
      admin.site.unregister(Group)

>通过以上步骤就已经完成了一个自定义的用户模型，需要重新使用./manager.py sync产生数据库。

[](http://lukecafe.com/2013/04/django-in-actioncustomize-user-system/)
