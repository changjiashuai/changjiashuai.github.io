---
layout: post
title: Swift体验2
date: 2014-06-04 14:09:32 +0800
comments: true
categories: [Swift]
---


## 控制流

使用`if`和`switch`做条件判断，使用`for-in`,`for`,`while`,`do-while`做循环
操作。括号中的条件或循环变量是可选的。括号的身体是必需的。

    let individualScores = [75, 43, 103, 87, 12]
    var teamScore = 0
    for score in individualScores{
      if score > 50{
        teamScore += 3
      }else{
        teamScore +=1
      }
    }
    teamScore

在if语句,条件必须是一个布尔表达式--这意味着像`if score {...}`的代码是一个错误的
不会隐式的和0比较。

你可以使用`if`和`let`来判断可能会丢失的值。这些值的表示为可选的。一个可选值包含一个
值或包含零表明缺失值。写一个问号(?)在类型的后面标记为值是可选的。

    var optionalString: String? = "Hello"
    optionalString == nil

    var optionalName: String? = "John Appleseed"
    var greeting = "Hello!"
    if let name = optionalName{
      greeting = "Hello, \(name)"
    }

>实验
改变optionalName的值为nil，观察greeting的值？增加一个else分支设置当oprionalName==nil
时greeting的值

如果可选值为nil，判断条件为false此块代码跳过，否则可选值赋值给let后的常量，这个值在
后面的代码块中可以获取到。

switch支持任何类型的数据和各种各样的比较操作，不受限与整数值和测试数量。

    let vegetable = "red pepper"
    switch vegetable{
      case "celery":
          let vegetableComment = "Add some raisins and make ants on a log."
      case "cucumber", "watercress":
          let vegetableComment = "That would make a good tea sandwich."
      case let x where x.hasSuffix("pepper"):
          let vegetableComment = "Is it a spicy \(x)?"
      default:
          let vegetableComment = "Everything tastes good in soup."
    }

>实验
试着去掉default分支，看有什么错误？


switch执行匹配的分支语句后程序退出。不继续执行接下来的情况,所以不需要显式地在每个
分支后加break代码


用`for-in`去迭代字典中的键值对。

    let interestingNumbers = [
      "Prime": [2, 3, 5, 7, 11, 13],
      "Fibonacci": [1, 1, 2, 3, 5, 8],
      "Square": [1, 4, 9, 16, 25]
    ]

    var largest = 0
    for (kind, numbers) in interestingNumbers{
      for number > largest {
        largest = number
      }
    }
    largest

>实验
添加另一个变量来跟踪kind的数量,以及那最大的数字是什么。


用`while`重复执行代码直到条件改变

    var n = 2
    while n < 100 {
      n = n * 2
    }

    n

    var m = 2
    do{
      m = m * 2
    }while m < 100

    m

可以使用`..`来表示循环索引的范围

    var firstForLoop = 0
    for i in 0..3 {
      firstForLoop += i
    }
    firstForLoop


    var secondForLoop = 0
    for var i = 0; i < 3; ++i {
      secondForLoop += i
    }
    secondForLoop
