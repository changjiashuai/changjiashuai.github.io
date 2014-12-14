---
layout: post
title: "查看历史--Git日志 "
date: 2014-07-11 09:49:52 +0800
comments: true
categories: [git]
---



[git log](http://www.kernel.org/pub/software/scm/git/docs/git-log.html)命令可以显示所有的提交(commit).....

##显示补丁(patchs):

    $ git log -p

    commit da9973c6f9600d90e64aac647f3ed22dfd692f70
    Author: Robert Schiele <rschiele@gmail.com>
    Date:   Mon Aug 18 16:17:04 2008 +0200

        adapt git-cvsserver manpage to dash-free syntax

    diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
    index c2d3c90..785779e 100644
    --- a/Documentation/git-cvsserver.txt
    +++ b/Documentation/git-cvsserver.txt
    @@ -11,7 +11,7 @@ SYNOPSIS
     SSH:

     [verse]
    -export CVS_SERVER=git-cvsserver
    +export CVS_SERVER="git cvsserver"
     'cvs' -d :ext:user@server/path/repo.git co <HEAD_name>

     pserver (/etc/inetd.conf):

 ##日志统计
 如果用`--stat`选项使用`git log`,它会显示在每个提交（commit）中哪些文件被修改了，这些文件分别添加或删除了多少行内容。

     ➜  changjiashuai git:(master) git log --stat
    commit adf7bdbdbe5a8d11339109cc467cac4242d1562a
    Author: changjiashuai <changjiashuai@gmail.com>
    Date:   Thu Jul 10 16:04:35 2014 +0800

        --update test post

     ...13\345\257\274\345\205\245\345\210\260Android Studio.markdown" | 8 ++++++--
     1 file changed, 6 insertions(+), 2 deletions(-)

    commit e0239348407af7cde745994ba52761645da2e0df
    Author: changjiashuai <changjiashuai@gmail.com>
    Date:   Thu Jul 10 13:48:15 2014 +0800

        --update test post

     ...74\345\205\245\345\210\260Android Studio.markdown" | 19 +++++++++++++++++++
     ...\257\274\345\205\245\345\210\260Android Studio.md" | 19 -------------------
     2 files changed, 19 insertions(+), 19 deletions(-)

    commit 81020af469bb390c64e726ff9660ed9d7d8beea6
    Author: changjiashuai <changjiashuai@gmail.com>
    Date:   Thu Jul 10 13:45:17 2014 +0800

##格式化日志
你可以按你的要求来格式化日志输出。`--pretty`参数可以使用若干表现格式，如`oneline`:

    ➜  changjiashuai git:(master) git log --pretty=oneline
    adf7bdbdbe5a8d11339109cc467cac4242d1562a --update test post
    e0239348407af7cde745994ba52761645da2e0df --update test post
    81020af469bb390c64e726ff9660ed9d7d8beea6 --test add post blog
    e1550187da873a3545b3600da62d923c77a5effd --init my blog

或者你也可以使用`short`格式：

    ➜  changjiashuai git:(master) git log --pretty=short
    commit adf7bdbdbe5a8d11339109cc467cac4242d1562a
    Author: changjiashuai <changjiashuai@gmail.com>

        --update test post

    commit e0239348407af7cde745994ba52761645da2e0df
    Author: changjiashuai <changjiashuai@gmail.com>

        --update test post

    commit 81020af469bb390c64e726ff9660ed9d7d8beea6
    Author: changjiashuai <changjiashuai@gmail.com>

        --test add post blog

    commit e1550187da873a3545b3600da62d923c77a5effd
    Author: changjiashuai <changjiashuai@gmail.com>

        --init my blog

你也可用`medium`,`full`,`fuller`,`email`,`raw`。如果这些格式不完全符合你的要求，你也可以用`--pretty=format`参数（参见：[git log](http://www.kernel.org/pub/software/scm/git/docs/git-log.html)）来创建你自己的格式。

    ➜  changjiashuai git:(master) git log --pretty=format:'%h was %an, %ar, message: %s'
    adf7bdb was changjiashuai, 18 hours ago, message: --update test post
    e023934 was changjiashuai, 21 hours ago, message: --update test post
    81020af was changjiashuai, 21 hours ago, message: --test add post blog
    e155018 was changjiashuai, 21 hours ago, message: --init my blog

另一个有趣的事是：你可以用`--graph`选项来可视化你的提交图(commit graph)，就像下面这样：

    ➜  changjiashuai git:(master) git log --pretty=format:'%h : %s' --graph
    * adf7bdb : --update test post
    * e023934 : --update test post
    * 81020af : --test add post blog
    * e155018 : --init my blog

它会用ASCII字符来画出一个很漂亮的提交历史(commit history)线。

##日志排序

你也可以把日志记录按一些不同的顺序来显示。
*注意：git日志从最近的提交(commit)开始，并且从这里开始向它们父分支回溯。然而git历史可能包括多个互不关联的开发路线，这样有时提交(commit)显示出来就有点杂乱。*

如果你要指定一个特定的顺序，可以为git log命令添加顺序参数(ordering option)。

按默认情况，提交(commits)会按逆时间(reverse chronological)顺序显示。

但是你也可以指定`--topo-order`参数，这就会让提交(commits)按拓扑顺序显示（就是子提交在它们的父提交前显示）。如果你用git log命令按拓扑顺序来显示git仓库的提交日志，你会看到"开发线"(development lines)都会集合在一起。

    ➜  changjiashuai git:(master) git log --pretty=format:'%h : %s' --topo-order --graph
    * adf7bdb : --update test post
    * e023934 : --update test post
    * 81020af : --test add post blog
    * e155018 : --init my blog

你也可以用'--date-order'参数，这样显示提交日志的顺序主要按提交日期来排序. 这个参数和'--topo-order'有一点像，没有父分支会在它们的子分支前显示，但是其它的东东还是按交时间来排序显示。你会看到"开发线"(development lines)没有集合一起，它们会像并行开发(parallel development)一样跳来跳去的：

    $ git log --pretty=format:'%h : %s' --date-order --graph
    *   4a904d7 : Merge branch 'idx2'
    |\  
    * | 81a3e0d : updated packfile code to recognize index v2
    | *   dfeffce : merged in bryces changes and fixed some testing issues
    | |\  
    | * | c615d80 : fixed a log issue
    |/ /  
    | * 23f4ecf : Clarify how to get a full count out of Repo#commits
    | *   9d6d250 : Appropriate time-zone test fix from halorgium
    | |\  
    | * | decfe7b : fixed manifest and grit.rb to make correct gemspec
    | * | cd27d57 : added lib/grit/commit_stats.rb to the big list o' file
    | * | 823a9d9 : cleared out errors by adding in Grit::Git#run method
    | * |   4eb3bf0 : resolved merge conflicts, hopefully amicably
    | |\ \  
    | * | | ba23640 : Fix CommitDb errors in test (was this the right fix?
    | * | | 4d8873e : test_commit no longer fails if you're not in PDT
    | * | | b3285ad : Use the appropriate method to find a first occurrenc
    | * | | 44dda6c : more cleanly accept separate options for initializin
    | * | | 839ba9f : needed to be able to ask Repo.new to work with a bar
    | | * | d065e76 : empty commit to push project to runcoderun
    * | | | 791ec6b : updated grit gemspec
    * | | | 756a947 : including code from github updates
    | | * | 3fa3284 : whitespace
    | | * | d01cffd : whitespace
    | * | | a0e4a3d : updated grit gemspec
    | * | | 7569d0d : including code from github updates

最后，你也可以用 ‘--reverse'参数来逆向显示所有日志。
