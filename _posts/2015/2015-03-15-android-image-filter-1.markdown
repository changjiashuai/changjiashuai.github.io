---
layout: post
title: "Android 图像处理(1)"
description: Android 图像处理
modified: 2015-03-15 14:39:06 +0800
category: Android ImageFilter
tags: [Android, ImageFilter]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

##图像构成

[位图(bitmap)](http://baike.baidu.com/view/56073.htm)

(r, g, b, a)--->(pixel)--->image

##通过调整颜色处理图像

操作的对象是每个像素，我们可以改变图像的色相(Hue)、饱和度(Saturation)、明度(Luminance)
[ColorActivity](https://coding.net/u/changjiashuai/p/BitmapFilter/git/blob/master/app/src/main/java/com/cjs/bitmapfilter/ColorActivity.java)

##通过颜色矩阵处理图形

[ColorMatrixActivity](https://coding.net/u/changjiashuai/p/BitmapFilter/git/blob/master/app/src/main/java/com/cjs/bitmapfilter/ColorMatrixActivity.java)

### 颜色矩阵(ColorMatrix)

颜色矩阵M是一个5*4的矩阵，如图1所示。在Android中，颜色矩阵M是以一维数组m=[a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t]的方式进行存储的。

![](/images/ColorMatrix/ColorMatrix1.png)

在一张图片中，图像的RGBA（红色、绿色、蓝色、透明度）值决定了该图片所呈现出来的颜色效果。而图像的RGBA值则存储在一个5*1的颜色分量矩阵C中，由颜色分量矩阵C可以控制图像的颜色效果。颜色分量矩阵C如图2所示。

![](/images/ColorMatrix/ColorMatrix2.png)

要想改变一张图片的颜色效果，只需要改变图像的颜色分量矩阵即可。通过颜色矩阵可以很方便的修改图像的颜色分量矩阵。假设修改后的图像颜色分量矩阵为C1，则有如图3所示的颜色分量矩阵计算公式。

![](/images/ColorMatrix/ColorMatrix3.png)

由此可见，通过颜色矩阵修改了原图像的RGBA值，从而达到了改变图片颜色效果的目的。并且，通过如图3所示的运算可知，颜色矩阵M的第一行参数abcde决定了图像的红色成分，第二行参数fghij决定了图像的绿色成分，第三行参数klmno决定了图像的蓝色成分，第四行参数pqrst决定了图像的透明度，第五列参数ejot是颜色的偏移量。

通常，改变颜色分量时可以通过修改第5列的颜色偏移量来实现，如图4所示的颜色矩阵M1，通过计算后可以得知该颜色矩阵的作用是使图像的红色分量和绿色分量均增加100，这样的效果就是图片泛黄（因为红色与绿色混合后得到黄色）。

![](/images/ColorMatrix/ColorMatrix4.png)

除此之外，也可以通过直接对颜色值乘以某一系数而达到改变颜色分量的目的。如图5所示的颜色矩阵M2，将绿色分量放大了2倍，这样的效果就是图片泛绿色。

![](/images/ColorMatrix/ColorMatrix5.png)

###初始化颜色矩阵

    1, 0, 0, 0, 0
    0, 1, 0, 0, 0
    0, 0, 1, 0, 0
    0, 0, 0, 1, 0



##通过像素r,g,b,a分量处理图像
