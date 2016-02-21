---
layout: post
title: Swift基础---Tuples
date: 2014-06-06 14:24:52 +0800
comments: true
categories: [Swift]
---


>声明

    let http404Error = (404, "Not Found")
    // http404Error is of type (Int, String),
    // and equals (404, "Not Found")

>使用

    let (statusCode, statusMessage) = http404Error
    println("The status code is \(statusCode)")
    // prints "The status code is 404"

    println("The status message is \(statusMessage)")
    // prints "The status message is Not Found"

>忽略不用的值

    let (justTheStatusCode, _) = http404Error
    println("The status code is \(justTheStatusCode)")
    // prints "The status code is 404"

>通过索引访问

    println("The status code is \(http404Error.0)")
    // prints "The status code is 404"

    println("The status message is \(http404Error.1)")
    // prints "The status message is Not Found"

>指定Tuples的名字

    let http200Status = (statusCode: 200, description: "OK")

    println("The status code is \(http200Status.statusCode)")
    // prints "The status code is 200"

    println("The status message is \(http200Status.description)")
    // prints "The status message is OK"
