//
//  UIView+MGSmartView.m
//  CatAcademy
//
//  Created by Giovanni Lodi on 1/17/13.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import "UIView+MGSmartView.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (MGSmartView)

- (void)setFrameSize:(CGSize)size
{
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

- (void)setFrameWidth:(CGFloat)width
{
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

- (void)setFrameHeight:(CGFloat)height
{
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

- (void)setFrameOrigin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

- (void)setFrameOriginX:(CGFloat)x
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}

- (void)setFrameOriginY:(CGFloat)y
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = newFrame;
}


- (void)setCenterX:(CGFloat)x
{
    CGPoint newCenter = self.center;
    newCenter.x = x;
    self.center = newCenter;
}

- (void)setCenterY:(CGFloat)y
{
    CGPoint newCenter = self.center;
    newCenter.y = y;
    self.center = newCenter;
}

- (void)setTopRightPoint:(CGPoint)topRight
{
    [self setFrameOriginX:topRight.x - self.frame.size.width];
    [self setFrameOriginY:topRight.y];
}

- (void)setBottomLeftPoint:(CGPoint)bottomLeft
{
    [self setFrameOriginX:bottomLeft.x];
    [self setFrameOriginY:bottomLeft.y - self.frame.size.height];
}

- (void)setBottomRightPoint:(CGPoint)bottomRight
{
    [self setFrameOriginX:bottomRight.x - self.frame.size.width];
    [self setFrameOriginY:bottomRight.y - self.frame.size.height];
}

- (void)setRightSideAtX:(CGFloat)x
{
    [self setFrameOriginX:x - self.frame.size.width];
}

- (void)setBottomSideAtY:(CGFloat)y
{
    [self setFrameOriginY:y - self.frame.size.height];
}

- (void)centerInView:(UIView *)parentView
{
    CGPoint center = [self convertPoint:parentView.center fromView:parentView];
    [self setCenter:center];
}

- (void)hide
{
    self.layer.opacity = 0.0f;
}

- (void)show
{
    self.layer.opacity = 1.0f;
}

- (void)verticallyAlignViews:(NSArray *)views padding:(CGFloat)padding centerInView:(UIView *)parentView
{
    if ([views count] == 0) return;
    
    CGFloat totalHeight = padding * ([views count] - 1);
    for (UIView *view in views) {
        totalHeight += view.frame.size.height;
    }
    
    CGFloat y = parentView.center.y - totalHeight / 2;
    
    for (UIView *view in views) {
        [view setFrameOriginY:y];
        [view setCenterX:parentView.center.x];
        
        y += view.frame.size.height + padding;
    }
}

- (void)horizontallyAlignViews:(NSArray *)views padding:(CGFloat)padding availableWidth:(CGFloat)availableWidth
{
    NSMutableArray *rows = [NSMutableArray arrayWithObject:[NSMutableArray arrayWithCapacity:1]];
    
    CGFloat usedWidth = 0;
    for (UIView *view in views) {
        if (usedWidth + view.frame.size.width < availableWidth - 2 *padding) {
            usedWidth += view.frame.size.width;
            [[rows lastObject] addObject:view];
        } else {
            usedWidth = view.frame.size.width;
            [rows addObject:[NSMutableArray arrayWithObject:view]];
        }
    }

    CGFloat y = [(UIView *)[views objectAtIndex:0] frame].origin.y;
    for (NSMutableArray *row in rows) {
        CGFloat maxHeight = 0;
        CGFloat width = -padding;
        for (UIView *view in row) {
            if (view.frame.size.height > maxHeight) maxHeight = view.frame.size.height;
            width += view.frame.size.width + padding;
        }
        
        CGFloat x = availableWidth / 2.0 - width / 2.0;
        for (UIView *view in row) {
            [view setFrameOriginX:x];
            [view setFrameOriginY:y];
            
            x += view.frame.size.width + padding;
        }
        
        y += maxHeight + padding;
    }
}

@end
