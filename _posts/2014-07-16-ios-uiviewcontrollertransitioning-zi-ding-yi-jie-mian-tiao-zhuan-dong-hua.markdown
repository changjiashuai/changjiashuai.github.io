---
layout: post
title: "iOS UIViewControllerTransitioning 自定义界面跳转动画"
description: 自定义界面跳转动画
modified: 2014-07-16 14:18:06 +0800
category: iOS
tags: [iOS, animation]
image:
feature:
comments: true
mathjax:
featured: false
published: true
---

## 实现UIViewControllerTransitioningDelegate协议

UIViewControllerTransitioningDelegate可以控制view controller的出现（presenting）
，消失（dismissing），interacting（交互）动画。

##自定义动画步骤

+ 实现UIViewControllerAnimatedTransitioning协议
+ 实现方法

```
Performing a Transition

– animateTransition:  required method
– animationEnded:


Reporting Transition Duration

– transitionDuration:  required method
```


```
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);

    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         [transitionContext completeTransition:YES];
                     }];
}
```


##交互动画可以继承UIPercentDrivenInteractiveTransition

```
Accessing Transition Attributes

   completionCurve  property
   duration  property
   percentComplete  property
   completionSpeed  property


Managing a Transition

  – updateInteractiveTransition:
  – cancelInteractiveTransition
  – finishInteractiveTransition
```

##结合手势基本逻辑处理

```
- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Used when supplying it in delegate.
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of guesture
            CGFloat fraction = translation.y / 400.0;
            //Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);

            [self updateInteractiveTransition:fraction];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
    }
}
```

##在ViewController中应用步骤

+ 实现UIViewControllerTransitioningDelegate协议
+ vc.transitioningDelegate = self
+ 实现可选方法：

```
Getting the Animator Objects

– animationControllerForPresentedController:presentingController:sourceController:
– animationControllerForDismissedController:


Getting the Interactive Transition Object

– interactionControllerForPresentation:
– interactionControllerForDismissal:
```

+ 调用

```
[self presentViewController:vc animated:YES completion:nil];
```
