---
layout: post
title: "PullToRefreshLayout"
description: PullToRefreshLayout
headline: PullToRefreshLayout
modified: 2016-10-21
category: PullToRefreshLayout
tags: [Android, PullToRefreshLayout]
image:
feature:
comments: true
mathjax:
---

[![](https://jitpack.io/v/changjiashuai/PullToRefreshLayout.svg)](https://jitpack.io/#changjiashuai/PullToRefreshLayout)

> **Pull Refresh Layout Library , If you have any question or suggestion  with this library , welcome to tell me !**

## Introduction
`PullToRefreshLayout`是一个用法同系统`SwipeRefreshLayout`可灵活自定义下拉刷新、上拉加载视图的Android库.


## Demo

![默认HeaderViewAndFooterView](/assets/images/2016/10/screenshots/自定义HeaderViewAndFooterView.gif)
![自定义HeaderViewAndFooterView](/assets/images/2016/10/screenshots/自定义HeaderViewAndFooterView.gif)

## Usage

### Step 1

>Add this in your root `build.gradle` file (**not** your module `build.gradle` file):

``` Gradle
allprojects {
	repositories {
		...

		maven { url "https://jitpack.io" }
	}
}
```

#### Dependency

>Add this to your module's `build.gradle` file:

```Gradle
dependencies {
    ...

	compile 'com.github.changjiashuai:PullToRefreshLayout:v1.0.1'
    ...
}
```


### Step 2

Add the PullToRefreshLayout to your layout:

Simple

```xml
    <io.github.changjiashuai.pulltorefresh.PullToRefreshLayout
            android:id="@+id/pullToRefreshLayout"
            android:layout_width="match_parent"
            android:layout_height="match_parent">

        <android.support.v7.widget.RecyclerView
                android:id="@+id/recyclerView"
                android:layout_width="match_parent"
                android:layout_height="match_parent"/>

    </io.github.changjiashuai.pulltorefresh.PullToRefreshLayout>

    <!--app:headerView、app:footerView 设置布局视图-->
    <io.github.changjiashuai.pulltorefresh.PullToRefreshLayout
            android:id="@+id/pullToRefreshLayout"
            android:layout_width="match_parent"
            android:layout_height="match_parent"
            app:headerView="@layout/refresh_view"
            app:footerView="@layout/pull_view">
        <android.support.v7.widget.RecyclerView
                android:id="@+id/recyclerView"
                android:layout_width="match_parent"
                android:layout_height="match_parent"/>
    </io.github.changjiashuai.pulltorefresh.PullToRefreshLayout>
```

### Step 3

It's very simple use just like .

```java
   mRecyclerView = (RecyclerView) findViewById(R.id.recyclerView);
   mPullToRefreshLayout = (PullToRefreshLayout) findViewById(R.id.pullToRefreshLayout);

   mPullToRefreshLayout.setOnRefreshListener(new PullToRefreshLayout.OnRefreshListener() {
          @Override
          public void onRefresh() {
              Log.i(TAG, "onRefresh: ");
              mRecyclerView.postDelayed(new Runnable() {
                @Override
                public void run() {
                    mAdapter.setStrings(initData());
                    mPullToRefreshLayout.endRefresh();
                }
              }, 1000);
          }
   });
   mPullToRefreshLayout.setOnLoadMoreListener(new PullToRefreshLayout.OnLoadMoreListener() {
          @Override
          public void onLoadMore() {
              Log.i(TAG, "onLoadMore: ");
              mRecyclerView.postDelayed(new Runnable() {
                @Override
                public void run() {
                    mAdapter.insert(addData());
                    mPullToRefreshLayout.endLoadMore();
                }
              }, 1000);
          }
   });
   mRecyclerView.postDelayed(new Runnable() {
        @Override
        public void run() {
           mPullToRefreshLayout.autoRefresh();
        }
   }, 500);


   //可选设置
   mPullToRefreshLayout.setHeaderHeight(200);//设置刷新视图刷新时高度， 可滑动高度是这个的2倍
   mPullToRefreshLayout.setFooterHeight(200);//设置上拉视图加载时高度， 可滑动高度是这个的2倍

   mPullToRefreshLayout.setCanRefresh(false);//设置是否开启下拉刷新功能
   mPullToRefreshLayout.setCanLoadMore(false);//设置是否开启上拉加载功能

   // 默认使用 HeaderView FooterView  --> 可自定义支持任意View
   mPullToRefreshLayout.setHeaderView(mHeaderView);//替换默认下拉刷新视图
   mPullToRefreshLayout.setFooterView(mFooterView);//替换默认上拉加载视图
```

## Custom HeaderView and FooterView

See [HeaderView](https://github.com/changjiashuai/PullToRefreshLayout/tree/master/pulltorefresh/src/main/java/io/github/changjiashuai/pulltorefresh/HeaderView.java), [FooterView](https://github.com/changjiashuai/PullToRefreshLayout/tree/master/pulltorefresh/src/main/java/io/github/changjiashuai/pulltorefresh/FooterView.java) in pulltorefresh.
