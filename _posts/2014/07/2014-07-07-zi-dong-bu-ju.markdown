---
layout: post
title: 自动布局
date: 2014-07-07 08:33:15 +0800
comments: true
categories: [iOS]
---


> AutoLayout是一种基于约束的，描述性的布局系统。

      item1.attribute1 = multiplier * item2.attribute2 + constant

      + (id)constraintWithItem:(id)item1
                     attribute:(NSLayoutAttribute)attribute1
                     relatedBy:(NsLayoutRelation)relation
                        toItem:(id)item2
                     attribute:(NSLayoutAttribute)attribute2
                    multiplier:(CGFloat)multiplier
                      constant:(CGFloat)constant;

      Button.centerX = Superview.centerX
      // =>
      [NSLayoutConstraint constraintWithItem:button
                     attribute:NSLayoutAttributeCenterX
                     relatedBy:NsLayoutRelationEqual
                        toItem:superview
                     attribute:NSLayoutAttributeCenterX
                    multiplier:1.0
                      constant:0.0];

      Button.bottom = Superview.bottom - <padding>
      // =>
      [NSLayoutConstraint constraintWithItem:button
                     attribute:NSLayoutAttributeBottom
                     relatedBy:NsLayoutRelationEqual
                        toItem:superview
                     attribute:NSLayoutAttributeBottom
                    multiplier:1.0
                      constant:-padding];


## Visual Format Syntax

*1. Standard Space*

      [button]-[textField]

  ![](/assets/images/2014/07/AutoLayout/standardSpace.png)

*2. Width Constraint*

      [button(>=50)]

  ![](/assets/images/2014/07/AutoLayout/widthConstraint.png)

*3. Connection to Superview*

      |-50-[purpleBox]-50-|

  ![](/assets/images/2014/07/AutoLayout/connectionToSuperview.png)

*4. Vertical Layout*

      V:[topField]-10-[bottomField]

  ![](/assets/images/2014/07/AutoLayout/verticalLayout.png)

*5. Flush Views*

      [maroonView][blueView]

  ![](/assets/images/2014/07/AutoLayout/flushViews.png)

*6. Priority*

      [button(100@20)]

  ![](/assets/images/2014/07/AutoLayout/priority.png)

*7. Equal Widths*

      [button1(==button2)]

  ![](/assets/images/2014/07/AutoLayout/equalWidths.png)

*8. Multiple Predicates*

      [flexibleButton(>=70,<=100)]

  ![](/assets/images/2014/07/AutoLayout/multiplePredicates.png)

*9. A Complete Line of Layout*

      |-[find]-[findNext]-[findField(>=20)]-|

  ![](/assets/images/2014/07/AutoLayout/completeLayout.png)

























---
>[链接](http://www.onevcat.com/2012/09/autoayout/)
