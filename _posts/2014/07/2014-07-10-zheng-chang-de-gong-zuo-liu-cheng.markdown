---
layout: post
title: 正常的工作流程
date: 2014-07-10 15:29:39 +0800
comments: true
categories: [git]
---


修改文件，将它们更新的内容添加到索引中。
    $ git add file1 file2 file3
你现在为commit做好了准备，你可以使用[git diff](http://www.kernel.org/pub/software/scm/git/docs/git-diff.html)命令再加上--cached参数，看看哪些文件将被提交(commit)。
(如果没有--cached参数，git diff会显示当前你所有已做的但没有加入到索引里的修改。)你也可以使用git status命令来获得当前项目的一个状况。

    $ git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to          unstage)
    #
    #   modified:   file1
    #   modified:   file2
    #   modified:   file3
    #

如果你要做进一步的修改, 那就继续做, 做完后就把新修改的文件加入到索引中. 最后把他们提交：

    $ git commit

这会提示你输入本次修改的注释，完成后就会记录一个新的项目版本。除了用git add命令，还可以用

    $ git commit -a

这会自动把所有内容被修改的文件（不包括新创建的文件）都添加到索引中，并且同时把它们提交。
    *注：commit注释最好以一行短句子作为开头，来简要描述一下这次commit所作的修改(最好不要超过50个字符)；然后空一行再把详细的注释写清楚。这样就可以很方便的用工具把commit注释变成email通知，第一行作为标题，剩下的部分就作email的正文*

## Git跟踪的是内容不是文件
很多版本控制系统都提供了一个 "add" 命令：告诉系统开始去跟踪某一个文件的改动。但是Git里的 ”add” 命令从某种程度上讲更为简单和强大. git add 不但是用来添加不在版本控制中的新文件，也用于添加已在版本控制中但是刚修改过的文件; 在这两种情况下, Git都会获得当前文件的快照并且把内容暂存(stage)到索引中，为下一次commit做好准备。
