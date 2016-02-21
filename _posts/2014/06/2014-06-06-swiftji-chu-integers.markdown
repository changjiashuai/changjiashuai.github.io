---
layout: post
title: Swift基础---Integers
date: 2014-06-06 14:22:30 +0800
comments: true
categories: [Swift]
---


>integers提供了三种（8， 16， 32） signed unsigned Int

---
## Integer Bounds

    let minValue = UInt8.min   //0
    let maxValue = UInt8.max   //255


## Int

    let intValue = 42

## Double

    let pi = 3.14159
    let anotherPi = 3 + 0.14159

## 进制

    let decimalInteger = 17        //十进制
    let binaryInteger = 0b1001     //二进制
    let octalInteger = 0o21        //八进制
    let hexadecimalInteger = 0x11  //十六进制

## 科学表示法

    let decimalDouble = 12.1875
    let exponentDouble = 1.21875e1   //e--10^
    let hexadecimalDouble = 0xC.3p0  //p--2^

## 数字分割帮助阅读

    let paddedDouble = 000123.456
    let oneMillion = 1_000_000
    let justOverOneMillion = 1_000_000.000_000_1

## 类型转换

    let twoThousand: UInt16 = 2_000
    let one: UInt8 = 1
    let twoThousandAndOne = twoThousand + UInt16(one)

## Float都转成Double

    let three = 3
    let pointOneFourOneFiveNine = 0.14159
    let pi = Double(three) + pointOneFourOneFiveNine

    let intergerPi = Int(pi)      // 3
