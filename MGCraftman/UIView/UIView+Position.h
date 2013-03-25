//
//  UIView+Position.h
//  
//
//  Created by Giovanni Lodi on 3/25/13.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Position)

- (void)setOrigin:(CGPoint)origin;
- (void)setOriginX:(CGFloat)x;
- (void)setOriginY:(CGFloat)y;

- (void)setCenterX:(CGFloat)x;
- (void)setCenterY:(CGFloat)y;

- (void)setTopRightPoint:(CGPoint)topRight;
- (void)setTopLeftPoint:(CGPoint)topLeft;
- (void)setBottomLeftPoint:(CGPoint)bottomLeft;
- (void)setBottomRightPoint:(CGPoint)bottomRight;

- (void)setRightSideAtX:(CGFloat)x;
- (void)setBottomSideAtY:(CGFloat)y;

- (void)centerInView:(UIView *)parentView;

// TODO not sure how to properly structure these
- (void)verticallyAlignViews:(NSArray *)views padding:(CGFloat)padding centerInView:(UIView *)parentView;
- (void)horizontallyAlignViews:(NSArray *)views padding:(CGFloat)padding availableWidth:(CGFloat)availableWidth;

@end
