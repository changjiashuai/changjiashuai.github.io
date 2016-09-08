---
layout: post
title: Eclipse工程导入到Android Studio
date: 2014-07-06 16:49:51 +0800
comments: true
categories: [Eclipse, Android Studio]
---


+ 1、首先升级ADT到最新版本

+ 2、选择需要从Eclipse导出的工程，右键选择Export并选择Android下的
Generate Gradle Build Files 如图所示：

![](/assets/images/2014/07/android-export.png)

+ 3、选择完毕后并不会导出到其他地方，而是在本地工程生成一个build.gradle
文件，在Eclipse工程中也可以看到，这个文件是Android Studio识别的，如图所示：

![](/assets/images/2014/07/android-gradle.png)

+ 4、随后进入Android Studio并选择Import Project，可以看到刚刚在Eclipse中的项目图标
编程了一个Android机器人图标，说明转换成功，这时候选择工程导入即可：
