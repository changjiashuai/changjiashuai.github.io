//: Playground - noun: a place where people can play

import Cocoa

var str = "Singleton"

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
