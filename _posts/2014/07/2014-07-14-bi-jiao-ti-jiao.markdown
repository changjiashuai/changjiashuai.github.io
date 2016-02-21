---
layout: post
title: 比较提交
date: 2014-07-14 16:27:35 +0800
comments: true
categories: [git]
---


你可以用[git diff](http://www.kernel.org/pub/software/scm/git/docs/git-diff.html)
来比较项目中任意两个版本的差异。

```
$ git diff master..test
```

上面这条命令只显示两个分支间的差异，如果你想找出‘master’,‘test’的共有父分支和'test'分支之间的差异，
你用3个`.`来取代前面的两个`.`

```
$ git diff master...test
```

[git diff](http://www.kernel.org/pub/software/scm/git/docs/git-diff.html)
是一个难以置信的有用的工具，可以找出你项目上任意两点间的改动，或是用来查看别人提交进来的新分支。

你通常用[git diff](http://www.kernel.org/pub/software/scm/git/docs/git-diff.html)
来找你当前工作目录和上次提交与本地索引间的差异。

```
$ git diff
```

上面的命令会显示在当前的工作目录里的，没有staged(添加到索引中)，且在下次提交时 不会被提交的修改。

如果你要看在下次提交时要提交的内容(staged,添加到索引中),你可以运行：

```
$ git diff --cached
```

上面的命令会显示你当前的索引和上次提交间的差异；这些内容在不带"-a"参数,运行"git commit"命令时就会被提交。

```
$ git diff HEAD
```

上面这条命令会显示你工作目录与上次提交时之间的所有差别，这条命令所显示的内容都会在执行"git commit -a"命令时被提交。

## 更多的比较选项

如果你要查看当前的工作目录与另外一个分支的差别，你可以用下面的命令执行:

```
$ git diff test
```

这会显示你当前工作目录与另外一个叫'test'分支的差别。你也以加上路径限定符，只比较某一个文件或目录。

```
$ git diff HEAD -- ./lib
```

上面这条命令会显示你当前工作目录下的lib目录与上次提交之间的差别(或者更准确的说是在当前分支)。

如果不是查看每个文件的详细差别，而是统计一下有哪些文件被改动，有多少行被改动，就可以使用‘--stat'参数。

```
$>git diff --stat
 layout/book_index_template.html                    |    8 ++-
 text/05_Installing_Git/0_Source.markdown           |   14 ++++++
 text/05_Installing_Git/1_Linux.markdown            |   17 +++++++
 text/05_Installing_Git/2_Mac_104.markdown          |   11 +++++
 text/05_Installing_Git/3_Mac_105.markdown          |    8 ++++
 text/05_Installing_Git/4_Windows.markdown          |    7 +++
 .../1_Getting_a_Git_Repo.markdown                  |    7 +++-
 .../0_ Comparing_Commits_Git_Diff.markdown         |   45 +++++++++++++++++++-
 .../0_ Hosting_Git_gitweb_repoorcz_github.markdown |    4 +-
 9 files changed, 115 insertions(+), 6 deletions(-)
```
有时这样全局性的查看哪些文件被修改，能让你更轻松一点。
