//
//  UIView+MGSmartView.h
//  CatAcademy
//
//  Created by Giovanni Lodi on 1/17/13.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MGSmartView)

- (void)setFrameSize:(CGSize)size;
- (void)setFrameWidth:(CGFloat)width;
- (void)setFrameHeight:(CGFloat)height;

- (void)setFrameOrigin:(CGPoint)origin;
- (void)setFrameOriginX:(CGFloat)x;
- (void)setFrameOriginY:(CGFloat)y;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;

- (void)setTopRightPoint:(CGPoint)topRight;

- (void)setBottomLeftPoint:(CGPoint)bottomLeft;
- (void)setBottomRightPoint:(CGPoint)bottomRight;

- (void)setRightSideAtX:(CGFloat)x;
- (void)setBottomSideAtY:(CGFloat)y;

- (void)centerInView:(UIView *)parentView;

- (void)hide;
- (void)show;

- (void)verticallyAlignViews:(NSArray *)views padding:(CGFloat)padding centerInView:(UIView *)parentView;

// TODO add parameter to decide the alignment type in the super view?
- (void)horizontallyAlignViews:(NSArray *)views padding:(CGFloat)padding availableWidth:(CGFloat)availableWidth;

@end
