//
//  UILabel+SmartLabel.m
//  CatAcademy
//
//  Created by Giovanni Lodi on 1/17/13.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import "UILabel+SmartLabel.h"

@implementation UILabel (SmartLabel)

- (void)clearAndCenter
{
    [self setTextAlignment:NSTextAlignmentCenter];
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
