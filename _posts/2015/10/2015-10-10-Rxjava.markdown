---
layout: post
title: "Android RxJava"
description: Android RxJava
modified: 2015-1025 21:54:35 +0800
category: Android RxJava
tags: [Android, RxJava]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

## RxJava

## Operators By Category

### Creating Observables  创建
>Operators that originate new Observables.

+ `Create` — create an Observable from scratch by calling observer methods programmatically
  >从头开始创建一个通过调用观察者可观测的编程方法


  ---
    ~~~
      Observable.create(new OnSubscribe<String>() {
            @Override
            public void call(Subscriber<? super String> subscriber) {
                subscriber.onNext("Hello World!");
                subscriber.onCompleted();
            }
        }).subscribe(new Subscriber<String>() {
            @Override
            public void onCompleted() {
                System.out.println("Done");
            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(String s) {

            }
        });

+ `Defer` — do not create the Observable until the observer subscribes, and create a fresh Observable for each observer
  >不创建直到观察者订阅,并创建一个新的观察为每个观察者

  ---
    ~~~
      Observable.defer(new Func0<Observable<String>>() {
            @Override
            public Observable<String> call() {
                return Observable.create(new OnSubscribe<String>() {
                    @Override
                    public void call(Subscriber<? super String> subscriber) {
                        subscriber.onNext("haha");
                    }
                });
            }
        }).subscribe(new Subscriber<String>() {
            @Override
            public void onCompleted() {

            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(String s) {

            }
        });

        Observable.defer(() -> Observable.create(new OnSubscribe<String>() {
            @Override
            public void call(Subscriber<? super String> subscriber) {
                subscriber.onNext("haha");
            }
        })).subscribe(new Subscriber<String>() {
            @Override
            public void onCompleted() {

            }

            @Override
            public void onError(Throwable e) {

            }

            @Override
            public void onNext(String s) {

            }
        });

+ `Empty/Never/Throw` — create Observables that have very precise and limited behavior
  >创建 非常精确的和有限的 观察

+ `From` — convert some other object or data structure into an Observable
+ `Interval` — create an Observable that emits a sequence of integers spaced by a particular time interval
+ `Just` — convert an object or a set of objects into an Observable that emits that or those objects
+ `Range` — create an Observable that emits a range of sequential integers
+ `Repeat` — create an Observable that emits a particular item or sequence of items repeatedly
+ `Start` — create an Observable that emits the return value of a function
+ `Timer` — create an Observable that emits a single item after a given delay

### Transforming Observables  传递
>Operators that transform items that are emitted by an Observable.

+ `Buffer` — periodically gather items from an Observable into bundles and emit these bundles rather than emitting the items one at a time
+ `FlatMap` — transform the items emitted by an Observable into Observables, then flatten the emissions from those into a single Observable
+ `GroupBy` — divide an Observable into a set of Observables that each emit a different group of items from the original Observable, organized by key
+ `Map` — transform the items emitted by an Observable by applying a function to each item
+ `Scan` — apply a function to each item emitted by an Observable, sequentially, and emit each successive value
+ `Window` — periodically subdivide items from an Observable into Observable windows and emit these windows rather than emitting the items one at a time

### Filtering Observables  过滤
>Operators that selectively emit items from a source Observable.

+ `Debounce` — only emit an item from an Observable if a particular timespan has passed without it emitting another item
+ `Distinct` — suppress duplicate items emitted by an Observable
+ `ElementAt` — emit only item n emitted by an Observable
+ `Filter` — emit only those items from an Observable that pass a predicate test
+ `First` — emit only the first item, or the first item that meets a condition, from an Observable
+ `IgnoreElements` — do not emit any items from an Observable but mirror its termination notification
+ `Last` — emit only the last item emitted by an Observable
+ `Sample` — emit the most recent item emitted by an Observable within periodic time intervals
+ `Skip` — suppress the first n items emitted by an Observable
+ `SkipLast` — suppress the last n items emitted by an Observable
+ `Take` — emit only the first n items emitted by an Observable
+ `TakeLast` — emit only the last n items emitted by an Observable

### Combining Observables  组合
>Operators that work with multiple source Observables to create a single Observable

+ `And/Then/When` — combine sets of items emitted by two or more Observables by means of Pattern and Plan intermediaries
+ `CombineLatest` — when an item is emitted by either of two Observables, combine the latest item emitted by each Observable via a specified function and emit items based on the results of this function
+ `Join` — combine items emitted by two Observables whenever an item from one Observable is emitted during a time window defined according to an item emitted by the other Observable
+ `Merge` — combine multiple Observables into one by merging their emissions
+ `StartWith` — emit a specified sequence of items before beginning to emit the items from the source Observable
+ `Switch` — convert an Observable that emits Observables into a single Observable that emits the items emitted by the most-recently-emitted of those Observables
+ `Zip` — combine the emissions of multiple Observables together via a specified function and emit single items for each combination based on the results of this function
