---
layout: post
title: "Android Studio中六种依赖"
description: 在Android Studio中有六种依赖
headline: 在Android Studio中有六种依赖
modified: 2016-04-22
category: 在Android Studio中有六种依赖
tags: [Android Studio, 依赖]
image:
feature:
comments: true
mathjax:
---

# 在Android Studio中有六种依赖

Compile，Provided，APK，Test compile，Debug compile，Release compile

# Compile
compile是对所有的build type以及favlors都会参与编译并且打包到最终的apk文件中。

# Provided
Provided是对所有的build type以及favlors只在编译时使用，类似eclipse中的external-libs,只参与编译，不打包到最终apk。

# APK
只会打包到apk文件中，而不参与编译，所以不能再代码中直接调用jar中的类或方法，否则在编译时会报错

# Test compile
Test compile 仅仅是针对单元测试代码的编译编译以及最终打包测试apk时有效，而对正常的debug或者release apk包不起作用。

# Debug compile
Debug compile 仅仅针对debug模式的编译和最终的debug apk打包。

# Release compile
Release compile 仅仅针对Release 模式的编译和最终的Release apk打包。
