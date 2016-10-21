---
layout: post
title: "ProgressBar"
description: ProgressBar
headline: ProgressBar
modified: 2016-07-26
category: Android ProgressBar
tags: [Android, ProgressBar]
image:
feature:
comments: true
mathjax:
---


## CircleSeekbar

>an android circle seekbar library

<img src="/assets/images/2016/07/style1.gif" width="220"/>
<img src="/assets/images/2016/07/style2.gif" width="220"/>
<img src="/assets/images/2016/07/withshadow.gif" width="220"/>
<img src="/assets/images/2016/07/withtext.gif" width="220"/>
<img src="/assets/images/2016/07/download.gif" width="220"/>
<img src="/assets/images/2016/07/union.gif" width="220"/>

## quick start

#### 1.Add root build.gradle

```
 repositories {
        // ...
        maven { url "https://jitpack.io" }
 }
```

#### 2.Add build.gradle

```
dependencies {
	        compile 'com.github.feeeei:CircleSeekbar:v1.0.3'
	}
```

#### 3.Added to the XML

```
    <io.feeeei.circleseekbar.CircleSeekBar
        android:id="@+id/seekbar"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        app:wheel_max_process="100"
        />
```

## attrs

```
  <!-- process -->
  <attr name="wheel_max_process" format="integer" />
  <attr name="wheel_cur_process" format="integer" />

  <!-- reached style -->
  <attr name="wheel_reached_color" format="color" />
  <attr name="wheel_reached_width" format="dimension" />

  <!-- unReached style -->
  <attr name="wheel_unreached_color" format="color" />
  <attr name="wheel_unreached_width" format="dimension" />

  <!-- pointer style -->
  <attr name="wheel_pointer_color" format="color" />
  <attr name="wheel_pointer_radius" format="dimension" />

  <!--shadows style -->
  <attr name="wheel_has_pointer_shadow" format="boolean" />
  <attr name="wheel_has_wheel_shadow" format="boolean" />
  <attr name="wheel_pointer_shadow_radius" format="dimension" />
  <attr name="wheel_shadow_radius" format="dimension" />

  <!-- if you want to open the wheel shadow, open this can speed up the rendering speed -->
  <attr name="wheel_has_cache" format="boolean" />

  <!-- if you want to block touchListener,use like processBar,
   only allow the code to control the schedule, you can change this attribute to false -->
  <attr name="wheel_can_touch" format="boolean" />
```

# ProgressView
>Custom view scrollbar

![](/assets/images/2016/07/dQxTl2w.gif)
![](/assets/images/2016/07/wlUfKeN.gif)
![](/assets/images/2016/07/CdH9kit.gif)


自定义view实现下载进度的展示
控件完全自定义,字体大小,圆环宽度,实心或者空心,圆环的宽度，圆环的颜色，进度字体的粗细,字体颜色等等都可以自定义

## CircleProgressBar
> [CircleProgressBar](https://github.com/dinuscxj/CircleProgressBar)继承ProgressBar, 是包含实心和线条两种风格的圆环进度条. 此外, 进度值可以随意定制.
如果你对酷炫的进度条比较感兴趣, 或许你更喜欢 [LoadingDrawable](https://github.com/dinuscxj/LoadingDrawable).

![](/assets/images/2016/07/CircleProgressBar.gif?width=300)

### 用法

#### Gradle
 ```gradle
 dependencies {
    compile 'com.dinuscxj:circleprogressbar:1.1.1'
 }
 ```

#### 用在xml中:

```java
<com.dinuscxj.progressbar.CircleProgressBar
	android:id="@+id/line_progress"
	android:layout_marginTop="@dimen/default_margin"
	android:layout_width="50dp"
	android:layout_height="50dp" />
```

### 属性
有下面这些属性你可以设置:

The **style**:

* line (默认)
* solid_line
* solid

The **background color**

* background_color

The **progress text**:

* text color
* text size
* visibility
* format

The **progress circle**:

* width
* start_color
* end_color
* background color

The **progress_shader**

* linear (默认，如果start_color和end_color相同则不会设置shader)
* radial
* sweep

The **progress_stroke_cap**

* butt (默认)
* round
* square

The **line style**:

* width
* count

例如 :

```
<com.dinuscxj.progressbar.CircleProgressBar
	android:layout_width="50dp"
	android:layout_height="50dp"

	app:style="line"

	app:background_color="@color/holo_red_light"

	app:progress_text_color="@color/holo_purple"
	app:progress_text_size="@dimen/progress_text_size"
	app:draw_progress_text="true"
	app:progress_text_format_pattern="@string/progress_text_format_pattern"

	app:progress_stroke_width="1dp"
	app:progress_start_color="@color/holo_purple"
	app:progress_end_color="@color/holo_green_light"
	app:progress_background_color="@color/holo_darker_gray"

	app:progress_shader="sweep"

	app:progress_stroke_cap="round"

	app:line_width="4dp"
	app:line_count="30"/>
```

### 优点

1. 继承ProgressBar， 不必关心当前进度状态的保存， ProgressBar 已经在onSaveInstanceState（）和 onRestoreInstanceState(Parcelable state)
2. 定制性很强，可以设置两种风格的进度条，设置进度条的颜色和进度文本的颜色和大小， 由于代码中对于进度文本的格化化是使用的String.format(), 所以进度文本可以根据需要随意定制
3. 代码优雅，代码注释很全面，格式整齐，可以直接在xml中设置相关的属性。
