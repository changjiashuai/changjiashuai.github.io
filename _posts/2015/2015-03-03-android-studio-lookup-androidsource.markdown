---
layout: post
title: "Android Studio查看Android源码"
description: Android Studio查看Android源码
modified: 2015-03-03 17:34:06 +0800
category: AndroidStudio
tags: [Android, AndroidStudio]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

##下载源码
1. 使用repo从源码仓库下载[Source](http://source.android.com)
2. 从百度网盘下载别人下载好的[Android5.0](http://pan.baidu.com/s/1c0nhX5Y)

##编译源码
#####1. 进入Android 源码根目录
#####2. 执行

~~~
#这行命令的意思是编译idegen这个项目,生成idegen.jar文件.生成成功后,会显示这个jar包的位置,并显示 #### make completed successfully (20 seconds)####
mmm development/tools/idegen/
~~~

#####3. 执行

~~~
#这行命令的意思是生成对应的文件:android.iws, android.ipr, android.iml .
sh ./development/tools/idegen/idegen.sh
~~~

##导入到Android Studio
打开Android Studio,点击File>Open,选择刚刚生成的android.ipr就好了
