---
layout: post
title: "Git索引"
date: 2014-07-08 12:37:05 +0800
comments: true
categories: [git]
---


>Git索引是一个在你的工作目录和项目仓库间暂存区（staging area）。有了它，你可以把许多内容的修改一起提交（commit）。如果你创建了一个提交（commit），那么提交的是当前索引（index）里的内容，而不是工作目录中的内容。

##查看索引

使用[git status](http://www.kernel.org/pub/software/scm/git/docs/git-status.html)命令是查看索引内容的最简单办法。你运行git status命令，就可以看到：哪些文件被暂存了（就是在你的Git索引中），哪些文件被修改了但是没有暂存，还有哪些文件没有被跟踪（untracked）。

    ➜  RestKit git:(development) git status
    On branch development
    Your branch is up-to-date with 'origin/development'.

    nothing to commit, working directory clean

如果完全掌握了索引（index），你就一般不会丢失任何信息，只要你记得名字描述信息（name of the tree that it described）就能把它们找回来。
