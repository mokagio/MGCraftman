//
//  PaginatedScrollViewContainer.m
//  CatAcademy
//
//  Created by Giovanni Lodi on 1/29/13.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import "PaginatedScrollViewContainer.h"

@implementation PaginatedScrollViewContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = nil;
    }
    return self;
}

// See http://stackoverflow.com/questions/1220354/uiscrollview-horizontal-paging-like-mobile-safari-tabs
// and http://stackoverflow.com/questions/1220354/uiscrollview-horizontal-paging-like-mobile-safari-tabs/1373096#1373096

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView* child = nil;
    if ((child = [super hitTest:point withEvent:event]) == self) {
    	return self.scrollView;
    }
    return child;
}

@end
