---
layout: post
title: "iOS页面切换的几种方式"
date: 2014-05-15 12:32:45 +0800
comments: true
categories: [iOS]
---


##从一个视图控制器切换到另一个视图控制器的几种方式
1. 模态（modal）画面显示方式


        //显示模态画面
        [self presentModalViewController: ... animated: ... ];
        //关闭模态画面
        [self dissmissModalViewController: ... animated: ... ];

2. SwitchViewController中有2个控制器的属性：BViewController,CViewController
>点击按钮之后在B与C视图之间切换--多用于在一个页面中有时要显示或隐藏某个View


        [self.view insertSubview: 加载的新页面 atIndex: n ];

3.UITabBarController实现并列画面跳转


        //将5个ViewController实例放入TabBar的viewControllers属性中
        self.tabBarController.viewControllers = @[navFirst, navSecond, navThird, navFourth, navFifth];
        self.window.rootViewController = self.tabBarController;
        //将根控制器的视图加到应用程序的主窗口
        [self.window addSubview: self.tabBarController.view];

4.UINavigationController实现多层画面跳转，在导航控制器中，载入有层级关系的界面


        [self.navigationController pushViewController: ... animated: ... ];
        //弹出后返回到原视图
        [self.navigationController popViewController: ... animated: ... ];
