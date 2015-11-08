---
layout: post
title: "Swift基础---Optionals"
date: 2014-06-06 14:23:42 +0800
comments: true
categories: [Swift]
---


>描述

+ There is a value, and it equals x
+ There isn't a value at all

---
    let possibleNumber = "123"
    let convertedNumber = possibleNumber.toInt()
    // convertedNumber is inferred to be of type
    // "Int?", or "optional Int"

>`!`表示确定有值 `?`可能有值

    if convertedNumber {
      println("\(possibleNumber) has an integer value of \(convertedNumber!)")
    }else{
      println("\(possibleNumber) could not be converted to an integer")
    }

    // prints "123 has an integer value of 123"

>Optional Binding

    // 模板
    if let constantName = someOptional {
      statements
    }

    if let actualNumber = possibleNumber.toInt() {

      // 如果possibleNumber.toInt()返回可选值Int类型的值  
      println("\(possibleNumber) has an integer value of \(actualNumber)")

    }else{

      // 否则
      println("\(possibleNumber) could not be converted to an integer")

  }

    // prints "123 has an integer value of 123"

##nil

>可以设置可选值变量为一个特殊值nil

    var serverResponseCode: Int? = 404
    // serverResponseCode 包含一个Int值404

    serverResponseCode = nil
    // serverResponseCode现在没有值

    var surveyAnswer: String?
    // surveyAnswer自动被设置为nil


##Implicitly Unwrapped Optionals

    let possibleString: String? = "An optional string."
    println(possibleString!)
    // !要求这个值可以获取到

    // prints "An optional string."

    let assumedString: String! = "An implicitly unwrapped optional string."
    println(assumedString)
    // 没有!说明这个值不是必须要获取到的

    // prints "An implicitly unwrapped optional string."

---

    if assumedString {
      println(assumedString)
    }

    // prints "An implicitly unwrapped optional string."


---

    if let definiteString = assumedString {
      println(definitString)
    }

    // prints "An implicitly unwrapped optional string."
