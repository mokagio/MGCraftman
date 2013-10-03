//
//  UIView+Animation.m
//  CatAcademy
//
//  Created by Giovanni Lodi on 10/31/12.
//  Copyright (c) 2012 Memrise. All rights reserved.
//

#import "UIView+Animation.h"
#import <QuartzCore/QuartzCore.h>
#import <CPAnimationSequence/CPAnimationSequence.h>

static NSTimeInterval kDefaultDuration = 0.5;
static NSTimeInterval kDefaultDelay = 0.2;

static CGFloat kDefaultShakeAngle = M_PI / 128;
static CGFloat kDefaultShakeDuration = 0.2;
static NSUInteger kDefaultNumberOfShakes = 6;

@implementation UIView (Animation)

- (CGRect)initialFrameFromFrame:(CGRect)originalFrame forDirection:(TransitionDirection)direction
{
    CGRect frame = originalFrame;
    
    switch (direction) {
        case TransitionDirectionRightToLeft:
            frame.origin.x += self.frame.size.width;
            break;
        case TransitionDirectionBottomToTop:
            frame.origin.y += self.frame.size.height;
        default:
            break;
    }
    
    return frame;
}

- (CGRect)finalFrameFromFrame:(CGRect)orinalFrame forDirection:(TransitionDirection)direction
{
    CGRect frame = orinalFrame;
    
    switch (direction) {
        case TransitionDirectionRightToLeft:
            frame.origin.x -= self.frame.size.width;
            break;
        case TransitionDirectionBottomToTop:
            frame.origin.y -= self.frame.size.height;
            break;
        default:
            break;
    }
    
    return frame;
}

- (void)transitionFromSubView:(UIView *)oldView toSubView:(UIView *)newView direction:(TransitionDirection)direction withDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay callback:(voidCallback)callback
{
    {
        // 1. Add the new subview outside the window, on the right
        // 2. Move the current subview outside the window and in the mean time
        // move the new subview into the window.
        // The direction is from right to left
        // 3. Finally remove the old subview
        
        newView.frame = [self initialFrameFromFrame:newView.frame forDirection:direction];
        
        CGRect enteringFrame = [self finalFrameFromFrame:newView.frame forDirection:direction];
        CGRect exitingFrame = [self finalFrameFromFrame:oldView.frame forDirection:direction];
        
        // This way we're sure the new view is at the same index as the old one
        [self insertSubview:newView aboveSubview:oldView];
        
        [UIView animateWithDuration:duration
                              delay:delay
                            options:UIViewAnimationOptionAllowAnimatedContent | UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             newView.frame = enteringFrame;
                             oldView.frame = exitingFrame;
                             
                         } completion:^(BOOL finished) {
                             [oldView removeFromSuperview];
                             
                             if (callback) callback();
                         }];
    }
}

- (void)transitionFromSubView:(UIView *)oldView toSubView:(UIView *)newView direction:(TransitionDirection)direction withDuration:(NSTimeInterval)duration callback:(voidCallback)callback
{
    [self transitionFromSubView:oldView
                      toSubView:newView
                      direction:direction
                   withDuration:duration
                          delay:kDefaultDelay
                       callback:callback];
}

- (void)transitionFromSubView:(UIView *)oldView toSubView:(UIView *)newView direction:(TransitionDirection)direction withCallback:(voidCallback)callback
{
    [self transitionFromSubView:oldView
                      toSubView:newView
                      direction:direction
                   withDuration:kDefaultDuration
                          delay:kDefaultDelay
                       callback:callback];
}

#pragma mark - SHAKE

- (void)doShake
{
    [self doRecursiveShakeWithIndex:kDefaultNumberOfShakes duration:kDefaultShakeDuration callback:nil];
}

- (void)doShakeWithCallback:(voidCallback)callback
{
    [self doRecursiveShakeWithIndex:kDefaultNumberOfShakes duration:kDefaultShakeDuration callback:callback];
}

- (void)doShakeNumberOfTimes:(NSUInteger)numberOfShackes
                    duration:(NSTimeInterval)duration
                withCallback:(voidCallback)callback
{
    NSTimeInterval stepDuration = duration / numberOfShackes;
    [self doRecursiveShakeWithIndex:numberOfShackes duration:stepDuration callback:callback];
}

- (void)doRecursiveShakeWithIndex:(NSUInteger)index
                         duration:(NSTimeInterval)duration
                         callback:(voidCallback)callback
{
    if (index == 0) {
        [UIView animateWithDuration:(duration / 2)
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform transform = CGAffineTransformMakeRotation(0);
                             self.transform = transform;
                         } completion:^(BOOL finished) {
                             if (callback) callback();
                         }];
        return;
    }
    
    CGFloat angle = (index % 2) ? kDefaultShakeAngle : -kDefaultShakeAngle;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
                         self.transform = transform;
                     } completion:^(BOOL finished) {
                         [self doRecursiveShakeWithIndex:index-1 duration:duration callback:callback];
                     }];
}

#pragma mark - FADE OUT

- (void)fadeOutWithDuration:(NSTimeInterval)duration callback:(voidCallback)callback
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.layer.opacity = 0.0;
                     } completion:^(BOOL finished) {
                         if (callback) {
                             callback();
                         }
                     }];
}

- (void)fadeViews:(NSArray *)viewsToFade toValue:(CGFloat)opacity duration:(NSTimeInterval)duration callback:(voidCallback)callback
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         for (UIView *view in viewsToFade) {
                             view.layer.opacity = opacity;
                         }
                     } completion:^(BOOL finished) {
                         if (callback) {
                             callback();
                         }
                     }];
}

- (void)fadeOutViews:(NSArray *)viewsToFadeOut withDuration:(NSTimeInterval)duration callback:(voidCallback)callback
{
    [self fadeViews:viewsToFadeOut toValue:0.0f duration:duration callback:callback];
}


#pragma mark - BOUNCE

- (void)bounceWithOffset:(CGFloat)offset
               direction:(BounceDirection)direction
                duration:(NSTimeInterval)bounceDuration
           numberOfTimes:(NSUInteger)numberOfBounces
                callback:(voidCallback)callback;
{
    [self recursiveBounceWithOffset:offset
                          direction:direction
                           duration:bounceDuration
                      numberOfTimes:numberOfBounces
                        bouncesDone:0
                           callback:callback];
}

- (void)recursiveBounceWithOffset:(CGFloat)offset
                        direction:(BounceDirection)direction
                         duration:(NSTimeInterval)bounceDuration
                    numberOfTimes:(NSUInteger)numberOfBounces
                      bouncesDone:(NSUInteger)numberOfBouncesDone
                         callback:(voidCallback)callback
{
    numberOfBouncesDone++;
    voidCallback nextIteration = nil;
    if (numberOfBouncesDone == numberOfBounces) {
        if (callback) nextIteration = callback;
    } else {
        nextIteration = ^{
            [self recursiveBounceWithOffset:offset
                                  direction:direction
                                   duration:bounceDuration
                              numberOfTimes:numberOfBounces
                                bouncesDone:numberOfBouncesDone
                                   callback:callback];
        };
    }
    
    switch (direction) {
        case BounceDirectionUpDown:
            [self bounceUpDownWithOffset:offset duration:bounceDuration callback:nextIteration];
            break;
        case BounceDirectionLeftRight:
            [self bounceLeftRightWithOffset:offset duration:bounceDuration callback:nextIteration];
        default:
            break;
    }
}

- (void)bounceUpDownWithOffset:(CGFloat)offset
                      duration:(NSTimeInterval)duration
                      callback:(voidCallback)callback
{
    NSTimeInterval splitDuration = duration / 4;
    CGPoint center = CGPointMake(self.center.x, self.center.y);
    CGPoint top = CGPointMake(self.center.x, self.center.y - offset);
    CGPoint bottom = CGPointMake(self.center.x, self.center.y + offset);
    
    CPAnimationStep *centerTop = [CPAnimationStep after:0
                                                    for:splitDuration
                                                options:UIViewAnimationOptionCurveLinear
                                                animate:^{
                                                    self.center = top;
                                                }];
    CPAnimationStep *topCenter = [CPAnimationStep after:0
                                                    for:splitDuration
                                                options:UIViewAnimationOptionCurveLinear
                                                animate:^{
                                                    self.center = center;
                                                }];
    CPAnimationStep *centerBottom = [CPAnimationStep after:0
                                                    for:splitDuration
                                                   options:UIViewAnimationOptionCurveLinear
                                                animate:^{
                                                    self.center = bottom;
                                                }];
    CPAnimationStep *bottomCenter = [CPAnimationStep after:0
                                                    for:splitDuration
                                                   options:UIViewAnimationOptionCurveLinear
                                                animate:^{
                                                    self.center = center;
                                                }];
    CPAnimationStep *callbackStep = [CPAnimationStep for:0.0
                                     animate:^{
                                         if (callback) callback();
                                     }];
    CPAnimationSequence *bounce = [CPAnimationSequence sequenceWithSteps:centerTop,
                                   topCenter,
                                   centerBottom,
                                   bottomCenter,
                                   callbackStep,
                                   nil];
    [bounce run];
}

- (void)bounceLeftRightWithOffset:(CGFloat)offset
                      duration:(NSTimeInterval)duration
                      callback:(voidCallback)callback
{
    NSTimeInterval splitDuration = duration / 4;
    CGPoint center = CGPointMake(self.center.x, self.center.y);
    CGPoint left = CGPointMake(self.center.x - offset, self.center.y );
    CGPoint right = CGPointMake(self.center.x + offset, self.center.y);
    
    CPAnimationStep *centerLeft = [CPAnimationStep after:0
                                                    for:splitDuration
                                                options:UIViewAnimationOptionCurveLinear
                                                animate:^{
                                                    self.center = left;
                                                }];
    CPAnimationStep *leftCenter = [CPAnimationStep after:0
                                                    for:splitDuration
                                                options:UIViewAnimationOptionCurveLinear
                                                animate:^{
                                                    self.center = center;
                                                }];
    CPAnimationStep *centerRight = [CPAnimationStep after:0
                                                       for:splitDuration
                                                   options:UIViewAnimationOptionCurveLinear
                                                   animate:^{
                                                       self.center = right;
                                                   }];
    CPAnimationStep *rightCenter = [CPAnimationStep after:0
                                                       for:splitDuration
                                                   options:UIViewAnimationOptionCurveLinear
                                                   animate:^{
                                                       self.center = center;
                                                   }];
    CPAnimationStep *callbackStep = [CPAnimationStep for:0.0
                                     animate:^{
                                         if (callback) callback();
                                     }];
    CPAnimationSequence *bounce = [CPAnimationSequence sequenceWithSteps:centerLeft,
                                   leftCenter,
                                   centerRight,
                                   rightCenter,
                                   callbackStep,
                                   nil];
    [bounce run];
}


#pragma mark - JUMP

- (void)jumpWithOffset:(CGFloat)offset
             direction:(JumpDirection)direction
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
              callback:(voidCallback)callback
{
    CGFloat xOffset = 0;
    CGFloat yOffset = 0;
    switch (direction) {
        case JumpDirectionBottom:
            yOffset = offset;
            break;
        case JumpDirectionLeft:
            xOffset = -offset;
            break;
        case JumpDirectionRight:
            xOffset = offset;
            break;
        case JumpDirectionUp:
            yOffset = -offset;
            break;
        default:
            break;
    }
    CGPoint jumpCenter = CGPointMake(self.center.x + xOffset, self.center.y + yOffset);
    CGPoint startingCenter = self.center;
    
    NSTimeInterval durationSplit = duration / 2;
    CPAnimationStep *jump = [CPAnimationStep after:delay
                                               for:durationSplit
                                           options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                                           animate:^{
                                               self.center = jumpCenter;
                                           }];
    CPAnimationStep *backToCenter = [CPAnimationStep after:0
                                                       for:durationSplit
                                                   options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                                                   animate:^{
                                                       self.center = startingCenter;
                                                   }];
    CPAnimationStep *callbackStep = [CPAnimationStep for:0
                                     animate:^{
                                         if (callback) callback();
                                     }];
    CPAnimationSequence *jumpSequence = [CPAnimationSequence sequenceWithSteps:jump,
                                 backToCenter,
                                 callbackStep,
                                 nil];
    [jumpSequence run];
}

- (void)jumpWithOffset:(CGFloat)offset
             direction:(JumpDirection)direction
              duration:(NSTimeInterval)duration
              callback:(voidCallback)callback
{
    [self jumpWithOffset:offset direction:direction duration:duration callback:callback];
}

@end
