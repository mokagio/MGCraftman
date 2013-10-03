//
//  MGRollingLabel.m
//  CatAcademy
//
//  Created by Gio on 29/07/2013.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import "MGRollingLabel.h"


static const CGFloat kStepDuration = 0.01;


@interface MGRollingLabel ()
@property (nonatomic, assign) CGFloat currentValue;
@property (nonatomic, assign) CGFloat startValue;
@property (nonatomic, assign) CGFloat endValue;
@property (nonatomic, assign) CGFloat increment;
@property (nonatomic, copy) NSString *valueFomat;
@end


@implementation MGRollingLabel

- (void)rollFromValue:(CGFloat)startValue
                   to:(CGFloat)endValue
           withFormat:(NSString *)format
             duration:(NSTimeInterval)duration
{
    [self rollFromValue:startValue
                     to:endValue
             withFormat:format
               duration:duration
                  delay:0];
}

- (void)rollFromValue:(CGFloat)startValue
                   to:(CGFloat)endValue
           withFormat:(NSString *)format
             duration:(NSTimeInterval)duration
                delay:(NSTimeInterval)delay
{
    if (startValue <= endValue) {
        self.increment = (kStepDuration / duration) * (endValue - startValue);
    } else {
        self.increment = -(kStepDuration / duration) * (startValue - endValue);
    }
	self.startValue = startValue;
    self.endValue = endValue;
    self.currentValue = startValue - self.increment;
    self.valueFomat = format;
    
    [self performSelector:@selector(rollRecursive) withObject:nil afterDelay:delay];
}

- (void)rollRecursive
{
    if (self.increment >= 0) {
        if (self.currentValue + self.increment >= self.endValue) {
            self.currentValue = self.endValue;
        } else {
            self.currentValue += self.increment;
            [self performSelector:@selector(rollRecursive) withObject:nil afterDelay:kStepDuration];
        }
    } else {
        if (self.currentValue + self.increment <= self.endValue) {
            self.currentValue = self.endValue;
        } else {
            self.currentValue += self.increment;
            [self performSelector:@selector(rollRecursive) withObject:nil afterDelay:kStepDuration];
        }
    }
    
    self.text = [NSString stringWithFormat:self.valueFomat, self.currentValue];
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)rollToEnd
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	self.currentValue = self.endValue;
	self.text = [NSString stringWithFormat:self.valueFomat, self.currentValue];
}

- (BOOL)hasFinished
{
	return self.currentValue == self.endValue;
}

- (BOOL)hasStarted
{
	return self.currentValue != self.startValue - self.increment;
}

@end
