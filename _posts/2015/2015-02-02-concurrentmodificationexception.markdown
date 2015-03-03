---
layout: post
title: "ConcurrentModificationException"
description: Java List ConcurrentModificationException
modified: 2015-02-02 17:31:06 +0800
category: Java List
tags: [Java, List, Exception]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

> 最近在写android程序的过程中，对容器ArrayList操作的时候，碰到了java.util.ConcurrentModificationException异常，是在遍历一个容器的时候，删除容器里面的元素：



    public static void exit(){
       for (Activity activity : activityList){
           activity.finish();
           activityList.remove(activity);
       }
    }

+ 官方文档中的说法是这样的：

  - This exception may be thrown by methods that have detected concurrent modification of an object when such modification is not permissible.（concurrent是同时发生，大概意思是当一个object被同时修改的时候，而且该修改是不允许的，就会报这个异常）

  -  For example, it is not generally permissible for one thread to modify a Collection while another thread is iterating over it（一个线程在修改容器，而另外一个线程在遍历这个容器，这样是不允许的）. In general, the results of the iteration are undefined under these circumstances. （这样做的会发生不确定的结果）Some Iterator implementations (including those of all the general purpose collection implementations provided by the JRE) may choose to throw this exception if this behavior is detected. （有一些容器的迭代器检测到这样的行为，就会抛出这个异常）Iterators that do this are known as fail-fast iterators, as they fail quickly and cleanly, rather that risking arbitrary, non-deterministic behavior at an undetermined time in the future.（这种称作fail-fast迭代器，它们失效的很快而且很干净利落而不是愿意冒发生不确定行为的危险， 大概就是说， 遇到这种情况迭代器自己直接就把自己给失效了）

  - Note that this exception does not always indicate that an object has been concurrently modified by a different thread. （这种异常不总是在一个object被不同线程同时修改时抛出， 即不是总是抛出这个异常）If a single thread issues a sequence of method invocations that violates the contract of an object, the object may throw this exception. For example, if a thread modifies a collection directly while it is iterating over the collection with a fail-fast iterator, the iterator will throw this exception.（当一个线程对一个容器操作的时候， 例如用fail-fast迭代器边遍历边修改这个容器，就是抛出这个异常）

  - Note that fail-fast behavior cannot be guaranteed as it is, generally speaking, impossible to make any hard guarantees in the presence of unsynchronized concurrent modification. Fail-fast operations throwConcurrentModificationException on a best-effort basis. Therefore, it would be wrong to write a program that depended on this exception for its correctness: ConcurrentModificationException should be used only to detect bugs.


 + 解决方案通常是使用Iterator的remove方法，我对几个常用的集合类都试了，是可以的。这样做的原理在于：

  - Iterator 是工作在一个独立的线程中，并且拥有一个 mutex 锁。 Iterator 被创建之后会建立一个指向原来对象的单链索引表，当原来的对象数量发生变化时，这个索引表的内容不会同步改变，所以当索引指针往后移动的时候就找不到要迭代的对象，所以按照 fail-fast 原则 Iterator 会马上抛出 java.util.ConcurrentModificationException 异常。

  - 所以 Iterator 在工作的时候是不允许被迭代的对象被改变的。但你可以使用 Iterator 本身的方法 remove() 来删除对象， Iterator.remove() 方法会在删除当前迭代对象的同时维护索引的一致性。
