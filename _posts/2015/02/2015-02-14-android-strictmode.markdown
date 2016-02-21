---
layout: post
title: Android StrictMode
description: Android StrictMode
modified: 2015-02-14 11:23:06 +0800
category: Android StrictMode
tags: [Android, StrictMode]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

最新的Android平台中(Android 2.3起)，新增加了一个新的类，叫StrictMode(android.os.StrictMode)。这个类可以用来帮助开发者改进他们编写的应 用，并且提供了各种的策略，这些策略能随时检查和报告开发者开发应用中存在的问题，比如可以监视那些本不应该在主线程中完成的工作或者其他的一些不规范和 不好的代码。

StrictMode有多种不同的策略，每一种策略又有不同的规则，当开发者违背某个规则时，每个策略都有不同的方法去显示提醒用户。在本文中，将举例子说明如何使用在Android 中使用 StrictMode。


## StrictMode的策略和规则

目前，有两大类的策略可供使用，一类是关于常用的监控方面的，另外一类是关于VM虚拟机等方面的策略。

#### 常用的监控方面的策略有如下这些：

1. Disk Reads 磁盘读
2. Disk Writes 磁盘写
3. Network access 网络访问
4. Custom Slow Code 自定义的运行速度慢的代码分析

前面三种的意思读者应该很清楚，就是正如它们的名字所示，分别对磁盘的读和写，网络访问进行监控。而第四种的自定义慢代码分析，是仅当访问调用类的 时候才触发的，可以通过这种方法去监视运行缓慢的代码。当在主线程中调用时，这些验证规则就会起作用去检查你的代码。比如，当你的应用在下载或者解析大量 的数据时，你可以触发自定义运行速度慢代码的查询分析，作用很大。StrictMode可以用于捕捉发生在应用程序主线程中耗时的磁盘、网络访问或函数调 用，可以帮助开发者使其改进程序，使主线程处理UI和动画在磁盘读写和网络操作时变得更平滑，避免主线程被阻塞的发生。

#### VM方面的策略重点关注如下几类：

1. 内存泄露的Activity对象
2. 内存泄露的SQLite对象
3. 内存泄露的释放的对象


其中，内存泄露的Activity对象和内存泄露的SQLite对象都比较好理解，而所谓对关闭对象的检查，主要是去监那些本该释放的对象，比如应该调用close()方法的对象。


当开发者违反某类规则时，每种策略都会有不同的方法令开发者知道当时的情况。相关的违反情况可以记录在LogCat中或者存储在DropBox中 (android.os.DropBox)服务中。而常用监控类的策略还会在当违规情况发生时显示相关的对话框和当时的上下文环境，所有的这些都为了能让 开发者尽快地了解程序的瑕疵，以提交程序的质量。

~~~
public void onCreate() {
     if (DEVELOPER_MODE) {
         StrictMode.setThreadPolicy(new StrictMode.ThreadPolicy.Builder()
                 .detectDiskReads()
                 .detectDiskWrites()
                 .detectNetwork()   // 这里可以替换为detectAll() 就包括了磁盘读写和网络I/O
                 .penaltyLog()   //打印logcat，当然也可以定位到dropbox，通过文件保存相应的log
                 .build());
         StrictMode.setVmPolicy(new StrictMode.VmPolicy.Builder()
                 .detectLeakedSqlLiteObjects() //探测SQLite数据库操作
                 .penaltyLog()  //打印logcat
                 .penaltyDeath()
                 .build());
     }
     super.onCreate();
 }
~~~
