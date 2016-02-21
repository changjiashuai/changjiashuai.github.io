---
layout: post
title: Swift基础---Assertions
date: 2014-06-06 14:27:03 +0800
comments: true
categories: [Swift]
---


    let age = -3
    assert(age >=0, "A person's age cannot be less than zero")

    // this causes the assertion to trigger, because age is not >= 0
