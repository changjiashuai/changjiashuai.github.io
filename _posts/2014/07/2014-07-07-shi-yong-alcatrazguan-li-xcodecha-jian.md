---
layout: post
title: 使用Alcatraz管理Xcode插件
date: 2014-07-07 15:42:43 +0800
comments: true
categories: [Xcode, Alcatraz]
---


>Alcatraz是一个帮你管理Xcode插件、模板以及颜色配置的工具。它可以直接集成到Xcode的图形界面中，让你感觉就像在使用Xcode自带的功能一样。

## 安装
    mkdir -p ~/Libray/Application\ Support/Developer/Shared/Xcode/Plug-ins
    curl -L http://git.io/lOQWeA | tar xvz -C ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins
## 删除
    rm -rf ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/Alcatraz.xcplugin
    rm -rf ~/Library/Application\ Support/Alcatraz

## 使用
>安装成功后重启Xcode，就可以在Xcode的顶部菜单中找到Alcatraz，如下所示：

![](/assets/images/2014/07/alcatraz-menu.jpg)

>点击`Package Manager`，即可启动插件列表页面，如下所示：

![](/assets/images/2014/07/alcatraz-home.jpg)

>之后你可以在右上角搜索插件，对于想安装的插件，点击左边图标，即可下载安装，如下所示：

![](/assets/images/2014/07/alcatraz-install.jpg)

>安装完成后，再次点击左边的图标，可以将该插件删除。

## 插件路径
>Xcode所有的插件都安装在此目录

`~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/`

## 注意
>Alcatraz当前只支持OSX10.9和Xcode5。可访问Alcatraz[官网](http://alcatraz.io)查看最新动态
