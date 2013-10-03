//
//  UIImage+Utils.m
//  CatAcademy
//
//  Created by Giovanni Lodi on 12/5/12.
//  Copyright (c) 2012 Memrise. All rights reserved.
//

#import "UIImage+Utils.h"
#import "UIScreen+Utils.h"
#import <QuartzCore/QuartzCore.h>

static NSString *const kRetina4Suffix = @"-568h"; // No @2x needed, remember the OS does it for us

@implementation UIImage (Utils)

// See http://stackoverflow.com/questions/4006495/how-to-darken-a-uiimageview
+ (UIImage *)imageByDarkeningImage:(UIImage *)image toLevel:(CGFloat)level;
{
    // Create a temporary view to act as a darkening layer
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    UIView *tempView = [[UIView alloc] initWithFrame:frame];
    tempView.backgroundColor = [UIColor blackColor];
    tempView.alpha = level;
    
    // Draw the image into a new graphics context
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [image drawInRect:frame];
    
    // Flip the context vertically so we can draw the dark layer via a mask that
    // aligns with the image's alpha pixels (Quartz uses flipped coordinates)
    CGContextTranslateCTM(context, 0, frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, frame, image.CGImage);
    [tempView.layer renderInContext:context];
    
    // Produce a new image from this context
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    return toReturn;
}

+ (UIImage *)screenDependentImageNamed:(NSString *)name
{
    NSString *screenDependentName = name;
    if ([UIScreen is4inchDisplay]) {
        screenDependentName = [screenDependentName stringByAppendingString:kRetina4Suffix];
    }
    else {
        // imageNamed is able to get the right @2x image by itself
    }
    
    return [UIImage imageNamed:screenDependentName];
}

+ (UIImage *)resizableImageNamed:(NSString *)name withCapInsets:(UIEdgeInsets)insets
{
    UIImage *baseImage = [UIImage imageNamed:name];
    return [baseImage resizableImageWithCapInsets:insets];
}

- (UIImage *)imageByResizingImageToSize:(CGSize)size
{
    UIImage *newImage = self;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [newImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
