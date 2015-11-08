---
layout: post
title: "采用现代Objective-C"
date: 2014-06-01 12:16:43 +0800
comments: true
categories: [iOS, Objective-C]
---

多年来，Objective-C语言已经有了革命性的发展。虽然核心理念和实践保持不变，
但语言中的部分内容经历了重大的变化和改进。现代化的Objective-C在类型安全、
内存管理、性能、和其他方面都得到了增强。使你更容易编写正确的代码。在你现有
和未来的代码中使用这些改进是很重要的，会使你的代码一致、可读、灵活。

Xcode提供了一个工具来帮助做这些结构性的变化。但在使用这个工具之前，你想了
解工具为你的代码做了什么改变以及为什么。本文强调了一些最重要的和有用的现代
化方式可以用在你的代码中。

##instancetype
>使用instancetype关键字作为返回类型的方法，该方法返回一个类的实例（或
该类的子类）这些方法包括alloc,init,和类工厂方法。

---
>使用instancetype代替id在适当的地方可以改善Objective-C代码类型安全。
例如：考虑下面的代码：

        @interface MyObject : NSObject
        + (instancetype)factoryMethodA;
        + (id)factoryMethodB;
        @end

        @implementation MyObject
        + (instancetype)factoryMethodA
        {
            return [[[self class] alloc] init];
        }

        + (id)factoryMethodB
        {
            return [[[self class] alloc] init];
        }
        @end

        void doSomething()
        {
            NSUinteger x, y;
            // Return type of +factoryMethodA is taken to be "MyObject *"
            x = [[MyObject factoryMethodA] count];
            // Return type fo +factoryMethodB is "id"
            y = [[MyObject factoryMethodB] count];
        }
>因为+factoryMethodA使用了instancetype作为返回类型，该消息的类型
表达式为MyObject *.当MyObject没有-count方法的时候，编译器会发出警
告的在x行：

        main.m: 'MyObject' may not respond to 'count'

>然而，由于+factoryMethodB返回类型为id，编译器不可以给出警告。因为
一个id可以是任何类型的对象类，由于存在一个名为-count的方法在一些类中，
编译器可能返回一个+factoryMehtodB的实现的方法。

>确保instancetype工厂方法有权利子类化行为，在初始化的时候一定要使用
`[self class]`而不是直接引用的类名。遵循这个惯例确保编译器将正确判
断出子类的类型。例如：考虑尝试这样做一个MyObject的子类从前面的示例：

        @interface MyObjectSubclass : MyObject

        @end

        void doSomethingElse()
        {
            NSString *aString = [MyObjectSubclass factoryMethodA];
        }

>关于这个代码编译器将给出下面的警告：

        main.m: Incompatible pointer types initializing 'NSString *'
        with an expression of type 'MyObjectSubclass *'

>在这个例子中,+factoryMethodA MyObjectSubclass类型的消息发送返回一个对象,
这是接收者的类型。编译器确定适当的返回类型+factoryMethodA应该是MyObjectSubclass
子类，而不是超类的工厂方法被调用。


---
>在你的代码中,出现id作为返回值替换为instancetype在适当的地方。这通常是init方法和类的工厂方法。
甚至编译器会自动转换以“alloc”、“init”、“new”开头的方法，而不转换其他的方法。objective-c对instancetype
的转换是显式的方式。

---
>请注意,您仅应该用instancetype替换id作为返回值,而不是在你的代码的任何地方都这么做。不像id，instancetype在
声明方法时仅仅只能作为返回值类型使用。

        例如：
        @interface MyObject
        - (id)myFactoryMethod;
        @end

        应该变为：
        @interface MyObject
        - (instancetype)myFactoryMethod;
        @end

>或者,您可以在Xcode使用现代objective-c变换器自动进行转换您的代码。更多信息请看[使用Xcode重构你的代码](http://#)。


##Properties
>一个public或private的Objective-C属性使用@property语法声明的。

        @property (readonly, getter=isBlue) BOOL blue;
>属性持有着一个对象的状态。他们反映对象的本质属性和其他对象的关系。Properties提供一个
安全、方便的方式来定义这些属性,而无需编写一组自定义访问器方法(虽然属性允许定制的getter和setter,如果需要的话)。

---
>使用属性而不是实例变量在尽可能多的地方提供了许多好处:

- 自动合成getters和setters。当你声明一个属性,默认情况下为你创建getter和setter方法。
- 更好的意图声明一组方法。因为访问器方法的命名约定方便,很明显getter和setter方法是做什么的。
- property关键字表示关于行为的额外信息。属性提供潜在的声明的属性像assign(vs copu),weak,atomic(vs nonatomic),等等。

---
>属性方法遵循一个简单的命名约定。getter属性的名称(例如,date),setter属性在名称前加前缀,按驼峰式命名书写(例如,setDate)。
Boolean属性的命名约定是声明他们的getter方法以'is'开头。

        @property (readonly, getter=isBlue) BOOL blue;
>因此,以下所有调用方式都可以正常工作:

        if(color.blue){}
        if(color.isBlue){}
        if([color isBlue]){}
>在决定什么可能是一个属性时,记住,如下不是属性:

- init方法
- copy方法，mutableCopy方法
- 一个类的工厂方法
- 一个初始化一个动作并返回BOOL值的方法
- 一个明确改变内部状态对getter有副作用的方法

>此外,考虑以下的规则集当在你的代码中定义属性时:

- 一个读/写属性有两个访问器方法。setter接受一个参数什么也不返回,getter不接受参数并返回一个值。
可以用readwrite关键字设置这个属性。
- 一个只读属性有一个访问器方法,getter不接受参数并返回一个值。可以使用readonly关键字设置。
- getter应该幂等的（如果一个getter方法调用了两次，那么第二次结果应该和第一次是相同的）。
但是,每次geeter被调用返回结果是可接受的。

###怎样适配
>定义一组方法,有资格被转换成属性,诸如此类的:

        - (NSColor *)backgroundColor;
        - (void)setBackgroundColor:(NSColor *)color;

---
>用@property语法和其他合适的关键字定义他们：

        @property (copy) NSColor *backgroundColor;

>更多关于property关键字和其他的信息，请看“Encapsulating Data”

>或者,您可以在Xcode使用现代objective-c变换器自动进行转换您的代码。更多信息请看[使用Xcode重构你的代码](http://jianshu.io/p/528eace594cd#)。


##Enumeration Macros
>NS_ENUM和NS_OPTIONS宏提供一个简洁、简单的定义枚举的方法和基于c语言的选项。
这些宏在Xcode中实现可以显式地指定枚举类型和选项的大小。此外,这种由旧的编译器语法声明枚举的方式,可以被新的编译器正确评估和解释潜在的类型信息。

---
>使用NS_ENUM宏定义枚举,互斥的一组值:

        typedef NS_ENUM(NSInteger, UITableViewCellStyle){
                UITableViewCellStyleDefault,
                UITableViewCellStyleValue1,
                UITableViewCellStyleValue2,
                UITableViewCellStyleSubtitle
        }

>NS_ENUM宏帮助定义枚举的名称和类型,在本例中名称为UITableViewCellStyle类型为NSInteger。
枚举类型应该是NSInteger。

---
>使用NS_OPTIONS宏来定义选项,一组位掩码值,可以组合在一起:

        typedef NS_OPTIONS(NSUInteger, UIViewAutoresizeing){
                UIViewAutoresizeingNone                    = 0,
                UIViewAutoresizeingFlexibleLeftMargin      = 1 << 0,
                UIViewAutoresizeingFlexibleWidth           = 1 << 1,
                UIViewAutoresizeingFlexibleRightMargin     = 1 << 2,
                UIViewAutoresizeingFlexibleTopMargin       = 1 << 3,
                UIViewAutoresizeingFlexibleHeight          = 1 << 4,
                UIViewAutoresizeingFlexibleBottomMargin    = 1 << 5
        }

>像这样的枚举,NS_OPTIONS宏定义一个名称和一个类型。然而,通常类型应该是NSUInteger。


###怎样适配
>代替你的枚举声明,如:

        enum{
                UITableViewCellStyleDefault,
                UITableViewCellStyleValue1,
                UITableViewCellStyleValue2,
                UITableViewCellStyleSubtitle
        };
        typedef NSInteger UITableViewCellStyle;

---
>用NS_ENUM语法：

        typedef NS_ENUM(NSInteger, UITableViewCellStyle){
                UITableViewCellStyleDefault,
                UITableViewCellStyleValue1,
                UITableViewCellStyleValue2,
                UITableViewCellStyleSubtitle
        }

>但是，当你使用enum去定义一个位掩码，想这样：

        enum {
                UIViewAutoresizeingNone                    = 0,
                UIViewAutoresizeingFlexibleLeftMargin      = 1 << 0,
                UIViewAutoresizeingFlexibleWidth           = 1 << 1,
                UIViewAutoresizeingFlexibleRightMargin     = 1 << 2,
                UIViewAutoresizeingFlexibleTopMargin       = 1 << 3,
                UIViewAutoresizeingFlexibleHeight          = 1 << 4,
                UIViewAutoresizeingFlexibleBottomMargin    = 1 << 5
        };
        typedef NSUInteger UIViewAutoresizing;

---
>用NS_OPTIONS宏：

        typedef NS_OPTIONS(NSUInteger, UIViewAutoresizeing){
                UIViewAutoresizeingNone                    = 0,
                UIViewAutoresizeingFlexibleLeftMargin      = 1 << 0,
                UIViewAutoresizeingFlexibleWidth           = 1 << 1,
                UIViewAutoresizeingFlexibleRightMargin     = 1 << 2,
                UIViewAutoresizeingFlexibleTopMargin       = 1 << 3,
                UIViewAutoresizeingFlexibleHeight          = 1 << 4,
                UIViewAutoresizeingFlexibleBottomMargin    = 1 << 5
        }

>或者,您可以在Xcode使用现代objective-c变换器自动进行转换您的代码。更多信息请看[使用Xcode重构你的代码](http://jianshu.io/p/528eace594cd#)。


##Automatic Reference Counting (ARC)
>自动引用计数(ARC)是一个编译器特性,它提供了Objective-C对象的自动内存管理。代替你不必记得使用retain,release
和autorelease。ARC评估对象的生命周期需求并自动插入适当的内存管理要求在编译时间。编译器也会为你产生适当的dealloc方法。


###怎样适配
>Xcode提供了一个工具,自动化转换的(如删除retain和release调用)帮助你解决不能自动修复的问题。使用ARC工具：
选择Edit > Refactor > Convert to Objective-C ARC。这个工具转换项目中所有的文件使用ARC。

---
>更多的信息，看Transitioning to ARC Release Notes.


##Refactoring Your Code Using Xcode
>Xcode提供了一个现代objective - c变换器,在转向现代化过程中可以帮助你。虽然转换器有助于识别和潜在应用现代化的机制,
但它没有解释代码的语义。例如,它不会发现-toggle方法是一种动作,影响你的对象的状态,并将错误地提供现代化这一行动是一个属性。
确保手动审查和确认任何转换器提供的使您的代码的更改。

---
>前面描述的现代化,转换器提供了:

+ 改变id到instancetype在合适的地方
+ 改变enum到NS_ENUM或NS_OPTIONS
+ 更新到@property语法

>除了这些现代化,这个转换器推荐额外的代码变更,包括:

+ 转换到字面意思，像[NSNumber numberWithInt:3]变成@3.
+ 用下标,像[dictionary setObject:@3 forKey:key]变成dictionary[key] = @3.

>使用modern Objective-C converter,Edit > Refactor > Convert to Modern Objective-C Syntax.
