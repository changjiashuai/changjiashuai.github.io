---
layout: post
title: swift体验1
date: 2014-06-04 14:09:04 +0800
comments: true
categories: [Swift]
---


一门新语言传统的入门方式是在屏幕上打印“Hello，wrold”。在Swift中你可以用下面一行
代码：

    println("Hello, world")

如果之前你用过C或Objective-C语言，这个语法和Swift中类似，这一行代码是一个完整的
程序。对这样的输入/输出或字符串处理你不需要导入单独的库文件。代码写在全局范围内被用
做整个程序的入口点。所以你不需要一个主函数。你不需要写分号(;)结束每一个声明。

这个旅程会给你足够的信息让你开始用Swift编写代码完成各种各样的编程任务。如果有些东西
不理解不要担心。在本书接下来的部分每个细节都会有详细的解释。

>注意：
为了有最佳的体验，在Xcode中以playground方式打开本章。Playground模式允许您编辑代
码清单并立即看到结果。


## 变量
用`let`创建常量，用`var`创建变量。这个常量的值在编译期不需要知道，但是在创建时必须
初始化。这意味着你可以使用常量赋值一次,而用在许多地方。

    var myVariable = 42
    myVariable = 50
    let myConstant = 42

一个常量或变量必须有相同的类型作为你想要分配给它的价值。然而,你并不总是需要编写显式
类型。提供一个值当你创建一个常量或变量值允许编译器推断它的类型。在上面的示例中,编译器
推断`myVariable`是一个整数,因为它的初始值是一个整数。

如果初始值不提供足够的信息(或者如果没有初始值),指定这一变量的类型,用冒号(:)隔开。

    let implicitInteger = 70
    let implicitDouble = 70.0
    let eximplicitDouble: Double = 70

>实验
用显示类型声明一个Float类型值为4的常量。

值从不隐式转换为另一种类型。如果您需要将一个值转换成不同的类型,明确想声明的类型。
的实例。

    let label = "The width is "
    let width = 94
    let widthLabel = label + String(width)

>实验
试试删除最后一行转换为字符串。你得到什么错误？

有一个更简单的方法将值转换为字符串，用`\(value)`这种方式。例如:

    let apples = 3
    let oranges = 5
    let appleSummary = "I have \(apples)."
    let fruitSummary = "I have \(apples + oranges) pieces of fruit."

>实验
使用\()包括一个浮点计算和一个字符串,包含在问候别人的名字中。

创建数组和字典使用方括号(`[]`),和访问他们的元素通过编写索引或键在括号中。

    var shoppingList = ["catfish", "water", "tulips",
    "blue paint"]
    shoppingList[1] = "bottle of water"

    var occupations = [
        "Malcolm": "Captain",
        "Kaylee": "Mechanic",
    ]
    occupations["Jayne"] = "Public Relations"

去创建一个空的数组或字典，用这个初始化语法。

    let emptyArray = String[]()
    let emptyDictionary = Dictionary<String, Float>()

如果可以推断类型信息,您可以编写一个空数组像这样`[]`和一个空的字典
像这样`[:]`。例如,当你为一个变量设置一个新值或传递一个函数的参数。

    shoppingList = [] //去购物，买了一切
