//
//  UIScreen+Utils.m
//  CatAcademy
//
//  Created by Giovanni Lodi on 3/11/13.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

static const CGFloat kRetina4Height = 568;

#import "UIScreen+Utils.h"

@implementation UIScreen (Utils)

+ (BOOL)is4inchDisplay
{
    return [[UIScreen mainScreen] bounds].size.height == kRetina4Height;
}

+ (CGFloat)windowHeightInPoints
{
    return [[UIScreen mainScreen] applicationFrame].size.height;
}

@end
