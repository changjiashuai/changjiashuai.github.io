---
layout: post
title: Android Renderscript（一）
description: Android Renderscript
modified: 2015-02-07 11:07:06 +0800
category: Android Renderscript
tags: [Android, Renderscript]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

渲染脚本（Renderscript）提供用C语言（C99标准）编写的原生级高性能的计算API。Renderscript
让你的应用程序有能力跨越所有可用的处理器内核来自动的平行的运行各种操作。它还提供了对不同类型
的处理的支持，如CPU、GPU或DSP等。Renderscript对于图形处理、数学模型或其他任何需要大量的数
学计算的应用程序都使用有用的。

另外，不需要编写代码你就能够访问所有这些功能来支持不同的架构或不同数量的处理器内核。也不需要
针对不同的处理器类型来编译你的应用程序，因为Renderscript代码是在设备上运行时被编译的。

注意：早期的Renderscript版本包含了一个实验性的图形引擎组件。这个组件限制被Android4.1
弃用了（rs_graphics.rsh中的大多数API和android.renderscript中对应的API）。如果你有使用
Renderscript来渲染图形的应用程序，强烈推荐你把代码转换到另外的Android图形渲染选项。

## Renderscript系统概述

Renderscript运行时的操作是原生级别的，并且依然需要跟Android的虚拟机（VM）进行通信，因此
创建一个Renderscript应用程序的方法不同于纯粹的虚拟机应用程序。除了你为程序编写的所需要的
Renderscript代码之外，使用Renderscript的应用程序依然是一个运行在虚拟机（VM）中的应用程序，
不管你使用它做什么，Renderscript依然保留它的平台独立性，因此不必编写多架构
（例如：ARM v5、ARM v7、x86）的Renderscript代码。

Renderscript系统采用了一个控制和从属的架构，在这个架构中低级别的Renderscript运行时代码是
由运行在虚拟机（VM）中高级别的Android来控制的。Android VM依然保留所有的对内存管理和分配给
Renderscript运行时的绑定内存的控制，因此Renderscript的代码能够访问它。Android框架使用
异步的方式调用Renderscript，并且调用会被放到消息队列中，直到它被处理。
图1显示了Renderscript系统的结构：

![](/assets/images/2015/02/renderscript1.png)

## 在使用Renderscript时，在Renderscript运行时和Android框架代码之间有三个层次来确保API的通信：

1. Renderscript运行时API，它允许执行应用程序所需要的计算。
2. 反射层API是一组从Renderscript运行代码中反射出来的类。它是围绕Renderscript代码的一个
   基本的封装，这个封装允许Android框架和Renderscript运行时进行交互。Android编译工具在编译
   期间会自动的生成这个层次的类。这些类跟NDK代码一样不需要编写JNI代码。
3. Android框架层，它调用反射层来访问Renderscript运行时。

## Renderscript的这种结构的主要优点是：

1. 便捷性：Renderscript被设计层可运行在不同处理器（CPU、GPU和DSP的实例）架构的很多设备上。
   它所支持的所有这些架构，都不是针对每个特定设备的，因为它的代码会在运行时在设备上被编译和缓存。
2. 高效性：Renderscript通过跨越设备上的过个内核，用并行的方式，提供了高性能的计算API。
3. 易用性：Renderscript在可能的情况下，简化了开发，如取消了JNI代码。

## 主要缺点是：

1. 开发的复杂性：Renderscript引入了一组新的需要你学习的API；

2. 调试的可见性：Renderscript可能在主CPU以外的处理器（如GPU）上执行（后续的发布计划中），
   因此如果发生这种事情，调试会变的更加困难。

## 创建Renderscript  
Renderscript扩大了设备上可用的处理器内核的范围。这种能力是通过名叫rsForEach()
(或者是Android框架级别下的forEach_root()方法)方法来获得的。它会自动的区分访问设备设备上
可用的处理器内核的工作。目前，Renderscript只能利用CPU内核的优势，但是在将来，它们会能够
运行在其他类型的处理器上，如GPU和DSP等。

实现一个Renderscript要涉及创建一个包含Renderscript代码的.rs文件和在Android框架级别下
用forEach_root()方法调用该文件（或者是在Renderscript级别下用rsForEach()函数调用该文件）。
下图介绍了如何建立一个典型的Renderscript：

![](/assets/images/2015/02/renderscript2.png)

## 以下章节介绍如何创建一个简单的Renderscript，并且要在一个Android应用程序中使用它。
  这个例子使用了SDK开发指南中提供的HelloCompute Renderscript示例。

## 创建Renderscript文件

Renderscript代码要保留在<project_root>/src/目录中的*.rs和*.rsh文件中。代码中包含了计算
的逻辑和所有必要的变量和指针的声明。通常，每个*.rs文件要包含下列项目：

1. 编译指示声明(#pragma rs java_package_name(package.name))，它声明了该Renderscript
   反射所对应的*.java类名；

2. 编译指示声明(#pragma version(1)),它声明了你要使用的Renderscript的版本(目前只能是1)

3. 一个名叫root()的主函数，该root()函数被rsForEach函数调用，并允许它调用Renderscript代码
   和在有效的多内核中执行。root()函数必须返回void并且要接收下列参数：

    A.分配给Renderscript的输入和输出使用的内存的指针。在Android3.2(API level 13)平台
      以前的版本中同时需要这两个指针。Android4.0（API Level 14）以后只分配其中之一就可以了。

    B.下列参数是可选的，但是如果使用它们就必须同时提供它们：

      除了必要的内存分配之外，一个Renderscript执行计算所可能需要的用户定义数据的指针，
      它能够指向一个简单的原始类型的数据，也可以指向一个复杂的结构体。
      用户定义数据的大小。

4. 一个可选的init()方法。这个方法允许再root()方法运行之前做一些初始化的工作，如初始化变量等。
   这个函数运行一次，并且在Renderscript启动时，Renderscript中其他工作被执行之前，该方法会
   被自动的调用。

5. 在Renderscript代码中要使用的任何变量、指针和结构体（如果需要，能够在*.rsh文件中声明）。

## 下列代码显示了mono.rs文件是如何实现的：

    #pragma version(1)
    #pragma rs java_package_name(com.example.android.rs.hellocompute)

    //multipliers to convert a RGB colors to black and white
    const static float3 gMonoMult = {0.299f, 0.587f, 0.114f};

    void root(const uchar4 *v_in, uchar4 *v_out) {
     //unpack a color to a float4
     float4 f4 = rsUnpackColor8888(*v_in);
     //take the dot product of the color and the multiplier
     float3 mono = dot(f4.rgb, gMonoMult);
     //repack the float to a color
     *v_out = rsPackColorTo8888(mono);
    }


## 调用Renderscript代码

你能够通过由实例化的类（ScriptC_script_name）来创建一个Renderscript对象从Android框架代      码中调用Renderscript。这个类包含了一个forEach_root（）方法，它会调用rsForeach()方法。
你能够传递给它与Renderscript运行时级别调用相同的参数。这种技术允许你的Android应用程序把
高精度的数学计算转交给Renderscript。

## 在Android框架层次调用Renderscript的方法：

1. 在你的Android框架代码中分配Renderscript所需要的内存。对于Androi3.2(API Level 13)
   以前的版本，需要分配输入和输出内存。Android4.0（API Level 14）以后的平台版本只需要
   分配其中之一的内存或两个都分配。
2. 创建ScriptC_scritp_name类的一个实例。
3. 调用forEach_root()方法，并传入分配的内存、Renderscript和其他的可选的用户定义的数据。
   输出内存中将会包含Renderscript的输出结果。

以下示例来自HellCompute示例，它处理一张位图，并输出它的黑白版本。CreateScript()方法
安装前面描述的步骤来执行。这个方法调用Renderscript对象，执行mono.rs脚本，把最终的处理
结果位图保存在输出的内存中，然后把处理后的位图显示在屏幕上：


    package com.example.android.rs.hellocompute;

    import android.app.Activity;
    import android.os.Bundle;
    import android.graphics.BitmapFactory;
    import android.graphics.Bitmap;
    import android.renderscript.RenderScript;
    import android.renderscript.Allocation;
    import android.widget.ImageView;

    public class HelloCompute extends Activity {
      private Bitmap mBitmapIn;
      private Bitmap mBitmapOut;
      private RenderScript mRS;
      private Allocation mInAllocation;
      private Allocation mOutAllocation;
      private ScriptC_mono mScript;

      @Override
      protected void onCreate(Bundle savedInstanceState) {
          super.onCreate(savedInstanceState);
          setContentView(R.layout.main);
          mBitmapIn = loadBitmap(R.drawable.data);
          mBitmapOut = Bitmap.createBitmap(mBitmapIn.getWidth(), mBitmapIn.getHeight(),
                                           mBitmapIn.getConfig());
          ImageView in = (ImageView) findViewById(R.id.displayin);
          in.setImageBitmap(mBitmapIn);
          ImageView out = (ImageView) findViewById(R.id.displayout);
          out.setImageBitmap(mBitmapOut);
          createScript();
      }

      private void createScript() {
          mRS = RenderScript.create(this);
          mInAllocation = Allocation.createFromBitmap(mRS, mBitmapIn,
              Allocation.MipmapControl.MIPMAP_NONE,
              Allocation.USAGE_SCRIPT);
          mOutAllocation = Allocation.createTyped(mRS, mInAllocation.getType());
          mScript = new ScriptC_mono(mRS, getResources(), R.raw.mono);
          mScript.forEach_root(mInAllocation, mOutAllocation);
          mOutAllocation.copyTo(mBitmapOut);
      }

      private Bitmap loadBitmap(int resource) {
          final BitmapFactory.Options options = new BitmapFactory.Options();
          options.inPreferredConfig = Bitmap.Config.ARGB_8888;
          return BitmapFactory.decodeResource(getResources(), resource, options);
      }
    }

## 以下是从另一个Renderscript文件中调用Renderscript的方法：

1. 在Android框架代码中分配由Renderscript所需要的内存。对于Android3.2平台和之前的版本，
   要同时分配输入和输出内存。Android4.0平台版本之后可以根据需要来分配输入和输出内存。
2. 调用rsForEach()方法，并传入分配的内存和可选的用户定义的数据。输出内存中会包含Renderscript
   的输出结果。


      rs_script script;
      rs_allocation in_allocation;
      rs_allocation out_allocation;
      UserData_t data;
      ...
      rsForEach(script, in_allocation, out_allocation,&data,sizeof(data));

在这个例子中，假定在Android框架层脚本和内存已经被分配和绑定，并且UserData_t是一个被事前
声明的结构。把这个结构的指针和它的大小传递一个rsForEach()方法，这是一个可选的参数。如果你
的Renderscript需要一些输入内存中之外的信息，就可以使用这个参数。

## 设置浮点精度

你能够定义计算规则所需要的浮点精度。如果你需要比IEEE 754-2008标准（默认使用的标准）更小的精度，
使用这个定义是有用的。你能够使用下列编译指令来定义脚本的浮点精度级别：


1. `#pragma rs_fp_full`(如果没指定，这是默认的精度级别)：指示应用程序需要由IEEE 754-2008
   标准所描述的浮点精度。
2. `#pragma rs_fp_relaxed`对于不需要严格遵从IEEE 754-2008标准要求精度的应用程序可以
   使用这种编译指令，对于de-norms（去模）计算这种模式启用了flush-to-zero（清零），
   并且round-towards-zero（向零方向舍入）。
3. `#pragma rs_fp_imprecise`对于没有严格精度要求的应用程序使用这种模式。这种模式沿用了
   rs_fp_relaxed模式以下的所有规则：

   - 操作结果-0.0会使用+0.0来代替返回；
   - 没有定义有关INF和NAN的操作。
