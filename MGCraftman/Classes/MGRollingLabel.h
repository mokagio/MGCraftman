//
//  MGRollingLabel.h
//  CatAcademy
//
//  Created by Gio on 29/07/2013.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import <MGInsetLabel.h>

@interface MGRollingLabel : MGInsetLabel

- (void)rollFromValue:(CGFloat)startValue
                   to:(CGFloat)endValue
           withFormat:(NSString *)format
             duration:(NSTimeInterval)duration;

- (void)rollFromValue:(CGFloat)startValue
                   to:(CGFloat)endValue
           withFormat:(NSString *)format
             duration:(NSTimeInterval)duration
                delay:(NSTimeInterval)delay;

- (void)rollToEnd;

- (BOOL)hasFinished;
- (BOOL)hasStarted;

@end
