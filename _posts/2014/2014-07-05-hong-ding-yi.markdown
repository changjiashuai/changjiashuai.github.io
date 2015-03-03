---
layout: post
title: "宏定义"
date: 2014-07-05 13:21:01 +0800
comments: true
categories: [iOS]
---


[](http://www.onevcat.com/2014/01/black-magic-in-macro/)

##对象宏
    #define M_PI 3.1415926535
    double r = 1.0;
    double circlePerimeter = 2 * M_PI * r;
    // => double circlePerimeter = 2 * 3.1415926535 * r
##函数宏
    #define FUNC(x) x
    NSLog(@"Hello %@", FUNC("world");
    // => NSLog(@"Hello %@", "world");
