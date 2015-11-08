---
layout: post
title: "Singleton"
description: Singleton
headline: swift java Singleton
modified: 2015-10-31
category: swift java Singleton
tags: [swift, java, Singleton]
image:
feature:
comments: true
mathjax:
---

## Swift


```

//: 第一种实现方式  懒汉
class Singleton: NSObject {
    class var shared: Singleton{
        dispatch_once(&Inner.token){
            Inner.instance = Singleton()
        }
        return Inner.instance!
    }

    struct Inner {
        static var instance: Singleton?
        static var token: dispatch_once_t = 0
    }
}

//: Test

let singleton1 = Singleton.shared
let singleton2 = Singleton.shared
assert(singleton1 === singleton2, "pass")


//: 第二种实现方式  饿汉
class Singleton2: NSObject{
    class var shared: Singleton2{
        return Inner.instance
    }

    struct Inner {
        static let instance = Singleton2()  //static 优化过 lazy load
    }
}

```

## Java


```

/**
 * lazy not thread safe
 */
class Singleton {
    private static Singleton instance;

    private Singleton() {
    }

    public static Singleton getInstance() {
        if (instance == null) {
            instance = new Singleton();
        }
        return instance;
    }

    /**
     * lazy thread safe
     * @return
     */
    public static synchronized Singleton getInstance2(){
        if (instance == null){
            instance = new Singleton();
        }
        return instance;
    }
}


class Singleton2{
    private static Singleton2 instance = new Singleton2();
    private Singleton2(){}
    public static Singleton2 getInstance(){
        return instance;
    }
}

class Singleton3{
    private Singleton3 instance = null;
    static {
        instance = new Singleton3();
    }
    private Singleton3(){}
    public static Singleton3 getInstance(){
        return instance;
    }
}

class Singleton4{
    private static class SingletonHolder{
        private static final Singleton4 INSTANCE = new Singleton4();
    }
    private Singleton4(){}
    public static final Singleton4 getInstance(){
        return SingletonHolder.INSTANCE;
    }
}

enum Singleton5{
    INSTANCE;
    public void whateverMethod(){}
}


class Singleton6{
    private volatile static Singleton5 singleton6;
    private Singleton6(){}
    public static Singleton6 getInstance(){
        if (singleton6 == null){
            synchronized (Singleton6.class){
                if (singleton6 == null){
                    singleton6 = new Singleton6();
                }
            }
        }
        return singleton6;
    }
}



```
