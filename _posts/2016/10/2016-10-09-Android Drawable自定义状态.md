---
layout: post
title: "Android Drawable 如何添加一个自定义的按钮状态"
description: Android Drawable自定义状态
headline: Android Drawable自定义状态
modified: 2016-10-09
category: Android Drawable自定义状态
tags: [Android, Drawable]
image:
feature:
comments: true
mathjax:
---

>增加状态的过程如下：

	>定义状态数组
	>重写protected int[] onCreateDrawableState(int extraSpace)
	>调用refreshDrawableState() --> call drawableStateChanged()
	>重写protected void drawableStateChanged()

1. 定义属性

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <declare-styleable name="food">
        <attr name="state_fried" format="boolean" />
        <attr name="state_baked" format="boolean" />
    </declare-styleable>
</resources>
```


2. 定义控件

```
public FoodButton(Context context, AttributeSet attrs) {
    super(context, attrs);
}

//定义状态数组
private static final int[] STATE_FRIED = {R.attr.state_fried};
private static final int[] STATE_BAKED = {R.attr.state_baked};

private boolean mIsFried = false;
private boolean mIsBaked = false;

public void setFried(boolean isFried) {mIsFried = isFried;}
public void setBaked(boolean isBaked) {mIsBaked = isBaked;}
Then override function "onCreateDrawableState":

//重写
@Override
protected int[] onCreateDrawableState(int extraSpace) {
    final int[] drawableState = super.onCreateDrawableState(extraSpace + 2);
    if (mIsFried) {
        mergeDrawableStates(drawableState, STATE_FRIED);
    }
    if (mIsBaked) {
        mergeDrawableStates(drawableState, STATE_BAKED);
    }
    return drawableState;
}
```

3. 定义Drawable xml

```
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res/com.mydomain.mypackage">
<item
    app:state_baked="true"
    app:state_fried="false"
    android:drawable="@drawable/item_baked" />
<item
    app:state_baked="false"
    app:state_fried="true"
    android:drawable="@drawable/item_fried" />
<item
    app:state_baked="true"
    app:state_fried="true"
    android:drawable="@drawable/item_overcooked" />
<item
    app:state_baked="false"
    app:state_fried="false"
    android:drawable="@drawable/item_raw" />
</selector>
```

