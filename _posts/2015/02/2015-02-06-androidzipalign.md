---
layout: post
title: Android-zipalign
description: Android zipalign
modified: 2015-02-06 15:19:06 +0800
category: Android zipalign
tags: [Android, zipalign]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

+ Android SDK中包含一个“zipalign”的工具，它能够对打包的应用程序进行优化。在你的应用程序上运行zipalign，使得在运行时Android与应用程序间的交互更加有效率。因此，这种方式能够让应用程序和整个系统运行得更快。我们强烈推荐在新的和已经发布的程序上使用zipalign工具来得到优化后的版本——即使你的程序是在老版本的Android平台下开发的。这篇文章将描述zipalign如何有助于性能改善以及如何使用它来优化你的app。


+ 在Android中，每个应用程序中储存的数据文件都会被多个进程访问：安装程序会读取应用程序的manifest文件来处理与之相关的权限问题；
Home应用程序会读取资源文件来获取应用程序的名和图标；系统服务会因为很多种原因读取资源（例如，显示应用程序的Notification）；此外，就是应用程序自身用到资源文件。


+ 在Android中，当资源文件通过内存映射对齐到4字节边界时，访问资源文件的代码才是有效率的。但是，如果资源本身没有进行对齐处理（未使用zipalign工具），
  它就必须回到老路上，显式地读取它们——这个过程将会比较缓慢且会花费额外的内存。


+ 对于应用程序开发者来说，这种显式读取方式是相当便利的。它允许使用一些不同的开发方法，包括正常流程中不包含对齐的资源，因此，
  这种读取方式具有很大的便利性（本段的原始意思请参考原文）。


+ 遗憾的是，对于用户来说，这个情况恰恰是相反的——从未对齐的apk中读取资源比较慢且花费较多内存。
最好的情况是，Home程序和未对齐的程序启动得比对齐后的慢（这也是唯一可见的效果）。最坏的情况是，安装一些未对齐资源的应用程序会增加内存压力，并因此造成系统反复地启动和杀死进程。最终，用户放弃使用如此慢又耗电的设备。


+ 幸运的是，对应用程序中的资源作对齐操作很简单：


+ 使用ADT：
  如果你使用导出向导的话，Eclipse中的ADT插件（从Ver. 0.9.3开始）就能自动对齐Release程序包。使用向导，右击工程属性，选择“Android Tools” > “Export Signed Application Package…”。当然，你还可以通过AndroidManifest.xml编辑器的第一页做到。


+ 使用Ant：
   Ant编译脚本（从Android 1.6开始）可以对齐程序包。老平台的版本不能通过Ant编译脚本进行对齐，必须手动对齐。
  从Android 1.6开始，Debug模式下编译时，Ant自动对齐和签名程序包。


+ Release模式下，如果有足够的信息签名程序包的话，Ant才会执行对齐操作，因为对齐处理发生在签名之后。  为了能够签名程序包，进而执行对齐操作，Ant必须知道keystore的位置以及build.properties中key的名字。相应的属性名为key.store和key.alias。如果这些属性为空，签名工具会在编译过程中提示输入store/key的密码，然后脚本会执行签名及apk文件的对齐。如果这些属性都没有，Release程序包不会进行签名，自然也就不会进行对齐了。


+ 手动：
  为了能够手动对齐程序包，Android 1.6及以后的SDK的tools/文件夹下都有zipalign工具。你可以使用它来对齐任何版本下的程序包。
  你必须在签名apk文件后进行，使用以下命令：`zipalign -v 4 source.apk destination.apk`


+ 验证对齐：
  以下的命令用于检查程序包是否进行了对齐：`zipalign -c -v 4 application.apk`
