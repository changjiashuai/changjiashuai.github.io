---
layout: post
title: "Android finish All activity"
description: Android finish All activity
modified: 2015-02-02 17:55:06 +0800
category: Android
tags: [Android, Finish]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

##android开发中如何结束所有的activity

一、每一个activity都有自己的生命周期，被打开了最终就要被关闭。

>四种结束当前的activity方法

    //关闭当前activity方法一  
      finish();  

    //关闭当前界面方法二  
      android.os.Process.killProcess(android.os.Process.myPid());  

    //关闭当前界面方法三  
      System.exit(0);  

    //关闭当前界面方法四  
      this.onDestroy();  

>如果已经启动了四个Activity：A，B，C和D，
    在D Activity里，想再启动一个Activity B，但不变成A,B,C,D,B，而是希望是A,B，而且B上的数据依然保留

    Intent intent = new Intent();  
    intent.setClass(DActivity.this,BActivity.class);  
    intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);//设置不要刷新将要跳到的界面  
    intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);//它可以关掉所要到的界面中间的activity  
    startActivity(intent);  

>如果已经启动了四个Activity：A，B，C和D，
在D Activity里，想再启动一个Activity B，但不变成A,B,C,D,B，而是希望是A,B，而且B上的数据不保留

    Intent intent = new Intent();  
    intent.setClass(DActivity.this,BActivity.class);  
    intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);//它可以关掉所要到的界面中间的activity  
    startActivity(intent);  

>如果已经启动了四个Activity：A，B，C和D，在D Activity里，
想再启动一个 Activity B，但不变成A,B,C,D,B，而是希望是A,C,D,B，则可以像下面写代码：


    Intent intent1 = new Intent(DActivity.this, BActivity.class);
    intent1.addFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
    startActivity(intent1);

>如果已经启动了四个Activity：A，B，C和D，在D Activity里，想要一次性关闭所有的activity
创建一个专门用来处理activity的类

    /**
     *
     *  一个类 用来结束所有后台activity
     *
     */
    public class SysApplication extends Application {  
        //运用list来保存们每一个activity是关键  
        private List<Activity> mList = new LinkedList<Activity>();  
        //为了实现每次使用该类时不创建新的对象而创建的静态对象  
        private static SysApplication instance;
        //构造方法  
        private SysApplication(){}  
        //实例化一次  
        public synchronized static SysApplication getInstance(){
            if (null == instance) {
                instance = new SysApplication();
            }
            return instance;
        }
        // add Activity
        public void addActivity(Activity activity) {
            mList.add(activity);
        }
        //关闭每一个list内的activity  
        public void exit() {
            try {
                for (Activity activity:mList) {
                    if (activity != null)
                        activity.finish();
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                System.exit(0);
            }
        }
        //杀进程  
        public void onLowMemory() {
            super.onLowMemory();
            System.gc();
        }
    }  

>在每个activity被创建时加上
    //将该activity添加到list中去。
    SysApplication.getInstance().addActivity(this);

>当你想关闭时，调用SysApplication的exit方法

    //关闭整个程序  
    SysApplication.getInstance().exit();  
