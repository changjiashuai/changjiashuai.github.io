---
layout: post
title: Git目录与工作目录
date: 2014-07-08 12:17:34 +0800
comments: true
categories: [git]
---


## Git目录

'Git目录'是为你的项目存储所有历史和元信息的目录--包括所有的对象（commits，trees，blobs，tags）
这些对象指向不同的分支。

每一个项目只能有一个'Git目录'（这和SVN，CVS的每个子目录中都有此类目录相反），这个叫'.git'的目录
在你项目的根目录下（这是默认设置，但并不是必须的）。如果你查看这个目录的内容，你可以看所有的重要文件：

    $>tree -L 1
    .
    |-- HEAD         # 这个git项目当前处在哪个分支里
    |-- config       # 项目的配置信息，git config命令会改动它
    |-- description  # 项目的描述信息
    |-- hooks/       # 系统默认钩子脚本目录
    |-- index        # 索引文件
    |-- logs/        # 各个refs的历史信息
    |-- objects/     # Git本地仓库的所有对象 (commits, trees, blobs, tags)
    `-- refs/        # 标识你项目里的每个分支指向了哪个提交(commit)。

(也许现在还有其它 文件/目录 在 'Git目录' 里面, 但是现在它们并不重要)

##工作目录
Git的'工作目录'存储着你现在签出（checkout）来用来编辑的文件。当你在项目的不同的分支间切换时，工作
目录里的文件经常会被替换和删除。所有历史信息都保存在'Git目录'中；工作目录只用来临时保存签出（checkout）
文件的地方，你可以编辑工作目录的文件直到下次提交（commit）为止。

*注*：'Git目录':一般就是指项目根目录下的'.git'目录。
