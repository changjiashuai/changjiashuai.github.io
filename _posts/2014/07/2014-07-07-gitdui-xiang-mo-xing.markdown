---
layout: post
title: git对象模型
date: 2014-07-07 15:02:29 +0800
comments: true
categories: [git]
---



## SHA

所有用来表示项目历史信息的文件,是通过一个40个字符的（40-digit）“对象名”来索引的，对象名看起来像这样:

      78fesc4664981e4397625791c8ea3bbb5f2279a3

你会在Git里到处看到这种“40个字符”字符串。每一个“对象名”都是对“对象”内容做SHA1哈希计算得来的，（SHA1是一种密码学的哈希算法）。这样就意味着两个不同内容的对象不可能有相同的“对象名”。

### 这样做会有几个好处：

1. Git只要比较对象名，就可以很快的判断两个对象是否相同。
2. 因为在每个仓库（repository）的“对象名”的计算方法都完全一样，如果同样的内容存在两个不同的仓库中，就会存在相同的“对象名”下。
3. Git还可以通过检查对象内容的SHA1的哈希值和“对象名”是否相同，来判断对象内容是否正确。

## 对象

每个对象(object) 包括三个部分：类型，大小和内容。大小就是指内容的大小，内容取决于对象的类型，有四种类型的对象："blob"、"tree"、 "commit" 和"tag"。

1. “blob”用来存储文件数据，通常是一个文件。
2. “tree”有点像一个目录，它管理一些“tree”或是 “blob”（就像文件和子目录）
3. 一个“commit”只指向一个"tree"，它用来标记项目某一个特定时间点的状态。它包括一些关于时间点的元数据，如时间戳、最近一次提交的作者、指向上次提交（commits）的指针等等。
4. 一个“tag”是来标记某一个提交(commit) 的方法。

## 与SVN的区别

Git与你熟悉的大部分版本控制系统的差别是很大的。也许你熟悉Subversion、CVS、Perforce、Mercurial 等等，
他们使用 “增量文件系统” （Delta Storage systems）, 就是说它们存储每次提交(commit)之间的差异。Git正好与之相反，它会把你的每次提交的文件的全部内容（snapshot）都会记录下来。
这会是在使用Git时的一个很重要的理念。

## Blob对象

一个blob通常用来存储文件的内容.

![](/assets/images/2014/07/git/object-blob.png)

你可以使用git show命令来查看一个blob对象里的内容。假设我们现在有一个Blob对象的SHA1哈希值，我们可以通过下面的的命令来查看内容：

      $ git show
      commit eafeb9f9d33e56375788e837b00566d4d7c4dbfc
      Merge: 2fec315 8ef9855
      Author: Blake Watters <blakewatters@gmail.com>
      Date:   Thu May 8 14:25:41 2014 -0700

      Merge pull request #1915 from FWDaniel/daniel/importbug

      Issue #1912: RKPathMatcher not imported

一个"blob对象"就是一块二进制数据，它没有指向任何东西或有任何其它属性，甚至连文件名都没有.

因为blob对象内容全部都是数据，如两个文件在一个目录树（或是一个版本仓库）中有同样的数据内容，
那么它们将会共享同一个blob对象。Blob对象和其所对应的文件所在路径、文件名是否改被更改都完全没有关系。

## Tree 对象

一个tree对象有一串(bunch)指向blob对象或是其它tree对象的指针，它一般用来表示内容之间的目录层次关系。

![](/assets/images/2014/07/git/object-tree.png)

git show命令还可以用来查看tree对象，但是git ls-tree能让你看到更多的细节。如果我们有一个tree对象的SHA1哈希值，我们可以像下面一样来查看它：

      RestKit git:(development) git ls-tree eafeb9f9d33e56375788e837b00566d4d7c4dbfc
      100644 blob 27edbf19050d28b857d998b75ad7fac663be1ee3	.gitignore
      100644 blob 032846b125fcb54421469440e4be0048b1aa9de1	.gitmodules
      100644 blob 28c0c5e6d4b42bacae9e68bceafb78063d768b9c	.ruby-version
      100644 blob 19f538416adcbed4b7927f7b045ba5e17bf3ef17	.travis.yml
      100644 blob bcbef9d8e353ca32f818d915f04d8ac55a201ec8	.xctool-args
      100644 blob 32ff5febdec90e25a88c2554e5a6c06570e00eb3	Brewfile
      100644 blob 763ff0b51e9ce0d6e84f8fe7eb5cb069c50e7103	CONTRIBUTING.md
      100644 blob 06bc559607655275ca5a1c82807cd9a261989797	CREDITS.md
      040000 tree 6c27b69cd47593c99f93cf307251249bd9aa6768	Code
      040000 tree abf5c9a7bb9e54f2ed996c8d498f7271c551af60	Docs
      040000 tree cfc4216ef6a0646b3a9bb91ea84a2b4b3056a009	Examples
      100644 blob d0162a01eb4e645f49f38a02877c9afc18d44a28	Gemfile
      100644 blob b3331b67edcb4f43e708d97563a021c8bef26d06	Gemfile.lock
      100644 blob eb8d4bc3bb0784782a09f234173cb4facd89378d	LICENSE
      100644 blob 6603056c2915a7887af32ae827c549255d4207b3	Podfile
      100644 blob 5c6c5b371d378d716f927ffc0d44c29238c011cf	Podfile.lock
      100644 blob 36adb4dc0cc9e1964579c2e61c6bb6ab04e1e503	README.md
      100644 blob df5320ada3837892a5584dc2ea8ac9e1871b4c0b	Rakefile
      040000 tree 4a37f7a777120659aecf1d6336cc3119d18b3a98	Resources
      100644 blob 32f93d9f4023f4041f7d6e46d9e57541154d6717	RestKit.podspec
      040000 tree 7d03fbb0fc2f5c2479328a6143611ddd0a56503f	RestKit.xcodeproj
      040000 tree d9b2d083f3a9b0da5a84f9eaae526d890a5e93ac	RestKit.xcworkspace
      040000 tree 0fb40af8290d7eb78044bbf359894ddbab74c40c	Tests
      100644 blob 91841d58e9fe7e68b6ca16db19a5a173c3c41d76	VERSION
      040000 tree f266d0eecef98134cfec0bbc0f70d0efd3b16886	Vendor

就如同你所见，一个tree对象包括一串(list)条目，每一个条目包括：mode、对象类型、SHA1值 和名字(这串条目是按名字排序的)。
它用来表示一个目录树的内容。

一个tree对象可以指向(reference): 一个包含文件内容的blob对象, 也可以是其它包含某个子目录内容的其它tree对象.
Tree对象、blob对象和其它所有的对象一样，都用其内容的SHA1哈希值来命名的；只有当两个tree对象的内容完全相同
（包括其所指向所有子对象）时，它的名字才会一样，反之亦然。这样就能让Git仅仅通过比较两个相关的tree对象的名字是否相同，
来快速的判断其内容是否不同。

*注意：*
1. 在submodules里，trees对象也可以指向commits对象. 请参见 Submodules 章节)
2. 所有的文件的mode位都是644 或 755，这意味着Git只关心文件的可执行位.

## Commit对象

"commit对象"指向一个"tree对象", 并且带有相关的描述信息.

![](/assets/images/2014/07/git/object-commit.png)

你可以用 --pretty=raw 参数来配合 git show 或 git log 去查看某个提交(commit):

      ➜  RestKit git:(development) git show -s --pretty=raw 2fec315
      commit 2fec3152db8733928c0fc122ba51fdf16d740261
      tree dd218a0425d969cb345716152a702d3a0d4bef4d
      parent 6ddbcfd2ae04a79ad7a6a9c8d457c34f9b8670ed
      parent 468ff4a28fbe9ec3876765736232f25e5f77a524
      author Blake Watters <blakewatters@gmail.com> 1399306351 -0700
      committer Blake Watters <blakewatters@gmail.com> 1399306351 -0700

          Merge pull request #1909 from MBulli/development

          Set RKCoreData.h to public group in copy header build phase

你可以看到, 一个提交(commit)由以下的部分组成:

1. 一个tree对象: tree对象的SHA1签名, 代表着目录在某一时间点的内容.

2. 父对象(parent(s)):提交(commit)的SHA1签名代表着当前提交前一步的项目历史. 上面的那个例子就有二个父对象;
合并的提交(merge commits)可能会有不只一个父对象. 如果一个提交没有父对象, 那么我们就叫它“根提交"(root commit),
它就代表着项目最初的一个版本(revision). 每个项目必须有至少有一个“根提交"(root commit). 一个项目可能有多个"根提交“，
虽然这并不常见(这不是好的作法).

3. 作者:做了此次修改的人的名字,还有修改日期.

4. 提交者（committer):实际创建提交(commit)的人的名字,同时也带有提交日期. TA可能会和作者不是同一个人;
例如作者写一个补丁(patch)并把它用邮件发给提交者, 由他来创建提交(commit).

5. 注释 用来描述此次提交.

*注意:*

1. 一个提交(commit)本身并没有包括任何信息来说明其做了哪些修改; 所有的修改(changes)都是通过与父提交(parents)的内容比较而得出的.
值得一提的是, 尽管git可以检测到文件内容不变而路径改变的情况, 但是它不会去显式(explicitly)的记录文件的更名操作.　
(你可以看一下[git diff](https://www.kernel.org/pub/software/scm/git/docs/git-diff.html)的-M参数的用法)

2. 一般用 git commit 来创建一个提交(commit), 这个提交(commit)的父对象一般是当前分支(current HEAD),　
同时把存储在当前索引(index)的内容全部提交.

## 对象模型

现在我们已经了解了3种主要对象类型(blob, tree 和 commit), 好现在就让我们大概了解一下它们怎么组合到一起的.

如果我们一个小项目, 有如下的目录结构:

    $>tree
    .
    |-- README
    `-- lib
        |-- inc
        |   `-- tricks.rb
        `-- mylib.rb

    2 directories, 3 files

如果我们把它提交(commit)到一个Git仓库中, 在Git中它们也许看起来就如下图:

![](/assets/images/2014/07/git/objects-example.png)

你可以看到: 每个目录都创建了tree对象(包括根目录),每个文件都创建了一个对应的blob对象。
最后有一个commit对象来指向根tree对象(root of trees),这样我们就可以追踪项目每一项提交内容.

##标签对象

![](/assets/images/2014/07/git/object-tag.png)

一个标签对象包括一个对象名(译者注:就是SHA1签名),对象类型,标签名,标签创建人的名字("tagger"),
还有一条可能包含有签名(signature)的消息。你可以用 [git cat-file](http://www.kernel.org/pub/software/scm/git/docs/git-cat-file.html)
命令来查看这些信息:

    ➜  RestKit git:(development) git cat-file tag v0.23.1
    object 751a21ed98602b7d8069e80dfd6d405fd23f987f
    type commit
    tag v0.23.1
    tagger Blake Watters <blake@layer.com> 1398314066 -0700

    Tagging v0.23.1

点击[git tag](http://www.kernel.org/pub/software/scm/git/docs/git-tag.html),
可以了解如何创建和验证标签对象.(注意:git tag同样也可以用来创建 "轻量级的标签"(lightweight tags),
但它们并不是标签对象,而只一些以"refs/tags/"开头的引用罢了).


+ [git--中文](http://gitbook.liuhui998.com/index.html)
+ [git--英文](http://git-scm.com/docs)
