//
//  UIView+Position.m
//  
//
//  Created by Giovanni Lodi on 3/25/13.
//
//

#import "UIView+Position.h"

@implementation UIView (Position)

- (void)setOrigin:(CGPoint)origin
{
    CGRect newFrame = self.frame;
    newFrame.origin = origin;
    self.frame = newFrame;
}

- (void)setOriginX:(CGFloat)x
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}

- (void)setOriginY:(CGFloat)y
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
    [self changeOriginX:topRight.x - self.frame.size.width];
    [self changeOriginY:topRight.y];
}

- (void)setBottomLeftPoint:(CGPoint)bottomLeft
{
    [self changeOriginX:bottomLeft.x];
    [self changeOriginY:bottomLeft.y - self.frame.size.height];
}

- (void)setBottomRightPoint:(CGPoint)bottomRight
{
    [self changeOriginX:bottomRight.x - self.frame.size.width];
    [self changeOriginY:bottomRight.y - self.frame.size.height];
}

- (void)setRightSideAtX:(CGFloat)x
{
    [self changeOriginX:x - self.frame.size.width];
}

- (void)setBottomSideAtY:(CGFloat)y
{
    [self changeOriginY:y - self.frame.size.height];
}

- (void)centerInView:(UIView *)parentView
{
    CGPoint center = [self convertPoint:parentView.center fromView:parentView];
    [self setCenter:center];
}

- (void)verticallyAlignViews:(NSArray *)views padding:(CGFloat)padding centerInView:(UIView *)parentView
{
    if ([views count] == 0) return;
    
    // Evaluate from where to start
    CGFloat totalHeight = padding * ([views count] - 1);
    for (UIView *view in views) {
        totalHeight += view.frame.size.height;
    }
    
    CGFloat y = parentView.center.y - totalHeight / 2;
    
    for (UIView *view in views) {
        [view changeOriginY:y];
        [view changeCenterX:parentView.center.x];
        
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
            [view changeOriginX:x];
            [view changeOriginY:y];
            
            x += view.frame.size.width + padding;
        }
        
        y += maxHeight + padding;
    }
}


@end
