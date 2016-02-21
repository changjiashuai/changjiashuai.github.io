---
layout: post
title: Swift基础---Booleans
date: 2014-06-06 14:21:06 +0800
comments: true
categories: [Swift]
---


>初始化

    let orangesAreOrange = true
    let turnipsAreDelicious = false

>使用

    if turnipsAreDelicious {
      println("Mmm, tasty turnips!")
    }else{
      println("Eww, turnips are horrible.")
    }


    let i = 1
    if i {
      // ---error
    }

    if i== 1 {
      // ---successfully
    }
