---
layout: post
title: Swift---泛型(Generics)
date: 2014-06-09 14:28:12 +0800
comments: true
categories: [Swift]
---


泛型使您能够编写灵活的、可重用的功能和类型的代码。

>例如要交换两个变量值的问题

## 不用泛型

    //Int类型交换
    func swapTwoInts(inout a: Int, inout b: Int){
      let temp = a
      a = b
      b = temp
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    println("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

    // prints "someInt is now 107, and anotherInt is now 3"

    //String类型交换
    func swapTwoStrings(inout a: String, inout b: String){
      let temp = a
      a = b
      b = temp
    }

    //Double类型交换
    func swapTwoDoubles(inout a: Double, inout b: Double){
      let temp = a
      a = b
      b = temp
    }

## 使用泛型

    func swapTwoValues<T>(inout a: T, inout b: T){
      let temp = a
      a = b
      b = temp
    }

    var someInt = 3
    var anotherInt = 107
    swapTwoValues(&someInt, &anotherInt)
    // someInt is now 107, and anotherInt is now 3

    var someString = "hello"
    var anotherString = "world"
    swapTwoValues(&someString, &anotherString)
    // someString is now "world", and anotherString is now "hello"


>Swift中自带的Array和Dictionary都是使用泛型实现的，下面通过泛型自定义简单的Stack

## 不用泛型

    struct IntStack{
      var items = Int[]()
      mutating func push(item: Int){
        item.append(item)
      }

      mutating func pop() -> Int {
        return items.removeLast()
      }
    }

## 使用泛型

    struct Stack<T>{
      var items = T[]()
      mutating func push(item: T){
        items.append(item)
      }

      mutating func pop() -> T {
        return items.removeLast()
      }
    }

    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    // the stack now contains 4 strings

    let fromTheTop = stackOfStrings.pop()
    // fromTheTop is equal to "cuatro", and the stack now contains 3 strings

>类型限制

    func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U){
      // function body goes here
    }

    func findStringIndex(array: String[], valueToFind: String) -> Int? {
      for(index, value) in enumerate(array) {
        if value == valueToFind {
          return index
        }
      }
      return nil
    }

    let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
    if let foundIndex = findStringIndex(strings, "llama") {
      println("The index of llama is \(foundIndex)")
    }

    // prints "The index of llama is 2"

    func findIndex<T>(array: T[], valueToFind: T) -> Int? {
      for(index, value) in enumerate(array) {
        if value == valueToFind {
          return index
        }
      }
      return nil
    }

    func findIndex<T: Equatable>(array: T[], valueToFind: T) -> Int? {
      for(index, value) in enumerate(array) {
        if value == valueToFind {
          return index
        }
      }
      return nil
    }

    let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
    // doubleIndex is an optional Int with no value,
    // because 9.3 is not in the array

    let stringIndex = findIndex(["Mike", "Malcolm", "Andrea"], "Andrea")
    // stringIndex is an optional Int containing a value of 2
