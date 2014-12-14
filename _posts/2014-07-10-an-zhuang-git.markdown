---
layout: post
title: "安装Git"
date: 2014-07-10 10:07:46 +0800
comments: true
categories: [git]
---


##从源代码开始安装

如果你在一个其基于Unix的系统中，你可以从Git的官网上[Git Download Page](http://git-scm.com/download)
下载它的源代码,并运行像下面的几行命令,你就可以安装:

    $ make prefix=/usr all ;# as yourself
    $ make prefix=/usr install ;# 以root权限运行

##Mac

    $ brew install git
