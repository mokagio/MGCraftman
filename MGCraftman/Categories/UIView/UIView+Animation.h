//
//  UIView+Animation.h
//  CatAcademy
//
//  Created by Giovanni Lodi on 10/31/12.
//  Copyright (c) 2012 Memrise. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^voidCallback)();

typedef enum _TransitionDirection {
    TransitionDirectionRightToLeft,
    TransitionDirectionBottomToTop
} TransitionDirection;

typedef enum _BounceDirection {
    BounceDirectionUpDown,
    BounceDirectionLeftRight,
} BounceDirection;

typedef enum _JumpDirection {
    JumpDirectionUp,
    JumpDirectionRight,
    JumpDirectionBottom,
    JumpDirectionLeft
} JumpDirection;

@interface UIView (Animation)

- (void)transitionFromSubView:(UIView *)oldView
                    toSubView:(UIView *)newView
                    direction:(TransitionDirection)direction
                 withCallback:(voidCallback)callback;

- (void)transitionFromSubView:(UIView *)oldView
                    toSubView:(UIView *)newView
                    direction:(TransitionDirection)direction
                 withDuration:(NSTimeInterval)duration
                     callback:(voidCallback)callback;

- (void)transitionFromSubView:(UIView *)oldView
                    toSubView:(UIView *)newView
                    direction:(TransitionDirection)direction
                 withDuration:(NSTimeInterval)duration 
                        delay:(NSTimeInterval)delay
                     callback:(voidCallback)callback;

- (void)doShake;
- (void)doShakeWithCallback:(voidCallback)callback;
- (void)doShakeNumberOfTimes:(NSUInteger)numberOfShackes
                    duration:(NSTimeInterval)duration
                withCallback:(voidCallback)callback;

- (void)fadeOutWithDuration:(NSTimeInterval)duration
                   callback:(voidCallback)callback;

- (void)fadeViews:(NSArray *)viewsToFade
          toValue:(CGFloat)opacity
         duration:(NSTimeInterval)duration
         callback:(voidCallback)callback;
- (void)fadeOutViews:(NSArray *)viewsToFadeOut
        withDuration:(NSTimeInterval)duration
            callback:(voidCallback)callback;

- (void)bounceWithOffset:(CGFloat)offset
               direction:(BounceDirection)direction
                duration:(NSTimeInterval)bounceDuration
           numberOfTimes:(NSUInteger)numberOfBounces
                callback:(voidCallback)callback;

- (void)jumpWithOffset:(CGFloat)offset
             direction:(JumpDirection)direction
              duration:(NSTimeInterval)duration
                 delay:(NSTimeInterval)delay
              callback:(voidCallback)callback;
- (void)jumpWithOffset:(CGFloat)offset
             direction:(JumpDirection)direction
              duration:(NSTimeInterval)duration
              callback:(voidCallback)callback;

@end
