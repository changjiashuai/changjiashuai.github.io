---
layout: post
title: "iOS坐标系统frame和bounds的区别（位置和大小）"
date: 2014-05-25 14:03:11 +0800
comments: true
categories: [iOS]
---


##iOS

>1. 首先左上角为坐标原点（0，0）
>2. CGPoint创建坐标点也就是位置
>3. CGSize表示视图宽度和高度
>4. CGRect结合了CGPoint和CGSize
>5. origin表示左上角所在的CGPoint
>6. frame是在父视图的CGRect
>7. bounds是指在自身视图中的CGRect
>8. center是指在父视图中的CGPoint

![](http://img.my.csdn.net/uploads/201303/24/1364058232_8785.jpg)

##cocos2d

>1. 首先左下角为坐标原点（0，0）
>2. anchorPoint中心点（0.5，0.5）
>3. bounds和frame相同
>4. position就是CGPoint
