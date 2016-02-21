---
layout: post
title: Android应用apk的程序签名
description: Android应用apk的程序签名
headline:
modified: 2015-12-18
tags:
image:
feature:
comments: true
mathjax:
---

## Android应用apk的程序签名

#### 关于Android应用程序签名主要有以下几个重点：

  1. 所有的应用程序都必须签名。系统不会安装任何一个没有签名的程序。这条规则适用于任何运行Android系统的地方，不管是真机还是模拟器。因此必须在模拟器或真机上运行/调试程序之前对程序进行签名。
  2. 可以使用自己的证书来签名。不需要任何授权中心。
  3. 要为最终用户发布应用程序的时候，必须签入一个合适的密钥。不可以发布程序的时候还使用SDK工具签入的Debug Key。
  4. 系统只在安装应用程序的时候检测证书的有效期。如果应用程序在安装之后证书失效了，应用程序依然可以正常工作。
  5. 可以使用标准工具——Keytool和Jarsigner生成Key并签名apk文件。
  6. 一旦为应用程序签名了，一定要使用zipalign工具来优化最终的APK包。

#### Debug Key和Release Key

在调试应用程序时，Android SDK工具会自动对应用程序进行了签名。Eclipse的ADT插件和Ant编译工具都提供了两种签名模式——Debug模式和Release模式。 在开发和测试时，可以使用Debug模式。Debug模式下，编译工具使用内嵌在JDK中的Keytool工具来创建一个keystore和一个 key（包含公认的名字和密码）。在每次编译的时候，会使用这个Debug Key来为apk文件签名。由于密码是公认的所以每次编译的时候，并不需要提示你输入keystore和key密码。

>当程序准备发布时，必须在Release模式下使用密钥来为apk文件签名。有以下两种方式可以做到：

1. 命令行中使用Keytool和Jarsigner。

这个方法中，首先需要编译出一个未签名的apk。然后使用Jarsigner（或类似的工具），用密钥为apk手动签名。如果没有合适的密钥，可以运行Keytool来手动生成自己的keystore/key。

2. 使用ADT导出向导。

如果使用Eclipse/ADT插件进行开发，可以使用导出向导来编译程序，生成密钥（如果需要），并为apk签名，所有这些操作都在导出向导中。一旦程序签名了，别忘了运行zipalign来为apk进行额外的优化。

#### 关于签名策略

应用程序签名的某些方面可能会影响应用程序的开发，特别是打算一起发布多个应用程序的时候。一般来说，推荐的策略是在整个应用程序寿命内，所有的程序都用相同的证书签名。主要出于以下几点考虑：

  1. 应用程序升级——在应用程序进行升级时，如果想用户平稳的升级，那么就需要签上相同的证书。当系统安装一个升级应用程序时，如果新版本的证书与老版本的证 书有匹配的话，那么，系统才会允许进行升级。如果没有为新版本程序签上合适的证书，那么在安装时需要给应用程序指定一个新的包名。这种情况下，用户安装的 新版本将当作是一个全新的应用程序。
  2. 应用程序模块化——如果应用程序声明，Android系统允许签有相同证书的应用程序运行在相同的进程里。这样系统将会把它们看作是一个单一的应用程序。用这种方法配置应用程序，用户可以选择更新每个独立的模块。
  3. 代码/数据权限共享——Android系统提供了基于签名的权限检查，因此如果应用程序间签有特定的证书，它们之间可以共享功能。通过多个程序签有相同的证书，并且使用基于签名的权限检查，程序可以以一种安全的方式共享代码和数据。
  4. 如果计划支持单个应用程序的升级，需要确保key拥有一个超过期望的应用程序生命周期的有效期。推荐使用25年或更长的有效期。当key过期后，用户也就不能平稳的更新到新的版本了。
  5. 如果给多个无关的应用程序签上了相同的key，那么应确保key的有效期超过所有应用程序所有版本的生命周期，包括将来有可能添加到这一阵营的程序。
  6. 如果想在Android Market上发布程序，key的有效期必须在2033.10.22以后。Market服务器强制这一要求，目的是保证用户可以平稳的更新他们的程序。

**在设计应用程序时，一定要考虑以上这些，并使用一个合适的证书来为应用程序签名。**

#### 配置签名环境

首先要保证`Keytool`对SDK编译工具来说是可利用的。一般可以通过设置`JAVA_HOME`环境变量来告诉SDK编译工具如何找到`Keytool`。另 外还可以添加JDK中`Keytool`的路径到PATH的变量里。 如果在Linux上开发，并且使用GNU编译器来编译Java，那么要确保系统是使用JDK中的`Keytool`，而不是`gcj`。如果`Keytool`已经在PATH中，它有可能是对`/usr/bin/keytool`的符号链接。这种情况下，要检查符号链接的目标，确保它是指向JDK中的`Keytool`。

如果要发布应用程序，还需要`Jarsigner`工具。`Jarsigner`和`Keytool`都包含在JDK中。


#### Debug模式下签名

Android编译工具提供了Debug签名模式，使得开发和调试应用程序更加容易，而且还满足Android系统的签名要求。在使用Debug模式编译app时，SDK工具会调用`Keytool`工具自动创建一个Debug的`keystore`和`key`。然后这个Debug key会自动用于apk的签名，这样就不需要手动为应用程序包签名了。

#### 关于SDK工具使用的keystore：

~~~
Keystore名字：“debug.keysotre”
Keystore密码：“android”
Key别名：“androiddebugkey”
Key密码：“android”
CN：“CN=Android Debug,O=Android,C=US”
~~~

如果需要可以改变Debug keystore/key的位置和名字，或者提供一个自定义的Debug keysotre/key（在Eclipse/ADT中，通过修改`Windows>Preferences>Android>Build`配置实现）。但是任何自定义的Debug keystore/key必须使用和默认Debug key（上面描述的）相同的名字和密码。

** 注意：不能将签有Debug证书的应用程序发布给最终用户。

Eclipse用户：如果在Eclipse/ADT下开发（并且已经按照上面的描述配置了Keytool），Debug模式下签名默认是开启的。运行或是调试应用程序 时，ADT会使用Debug证书进行签名，并运行zipalign，然后安装到选择的模拟器或是已连接的设备。整个过程不需要人工干预。

Ant用户：如果使用Ant来编译apk文件，则需要在ant命令中添加debug选项来开启Debug签名模式（假设正在使用由android工具生成`build.xml`文件）。运行ant debug编译程序时，编译脚本会生成一个keystore/key，并为apk进行签名。然后脚本会使用`zipalign`工具对apk进行对齐处理。整 个过程不需要人工干预。

#### Debug证书过期

Debug模式下签名用的证书自从它创建之日起，1年后就会失效。当证书失效时，会得到一个编译错误，Ant上错误如下：

~~~
1	debug:
2
[echo] Packaging bin/samples-debug.apk, and signing it with a debug key...
3	[exec] Debug Certificate expired on 8/4/08 3:43 PM
~~~

在Eclipse ADT中，Android控制台上也将会看到一个类似的错误。要解决这个问题，只需删掉`debug.keystore`文件即可。该文件默认存储的位置在：

OS X和Linux：`~/.android/`
Windows XP：`C:/Documents and Settings/.android/`
Windows Vista：`C:/Users/.android/`
删除后，在下一次编译的时候，编译工具会重新生成一个新的keystore和Debug key。


#### Release模式下签名

应用程序准备发布给其它用户时，需要：

  1. 获取一个合适的密钥
  2. 在Release模式下编译程序
  3. 使用密钥签名程序
  4. 对齐APK包
  5. 如果使用Eclipse ADT插件开发，可以使用导出向导来完成编译、签名和对齐等操作。整个过程中，导出向导还可以生成一个新的keystore和密钥。

#### 关于密钥的生成

为了进行程序签名，必须有一个合适的密钥。这个密钥应有以下特征：

  1. 个人持有。
  2. 代表个人、公司或组织实体的身份。
  3. 有一个有效期。有效期推荐超过25年。在Android Market上发布程序时需要注意：程序的有效期需要在2033.10.22之后。不能上传一个应用程序而它的key的有效期是在这个日期之前。
  4. 不是由Android SDK工具生成的Debug key。
  5. 如果没有合适的key，则需要使用Keytool来生成一个。用Keytool生成一个key，可使用keytool命令并传入一些可选参数。
