//
//  UIImage+Utils.h
//  CatAcademy
//
//  Created by Giovanni Lodi on 12/5/12.
//  Copyright (c) 2012 Memrise. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage *)imageByDarkeningImage:(UIImage *)image toLevel:(CGFloat)level;

+ (UIImage *)screenDependentImageNamed:(NSString *)name;

+ (UIImage *)resizableImageNamed:(NSString *)name withCapInsets:(UIEdgeInsets)insets;

- (UIImage *)imageByResizingImageToSize:(CGSize)size;

@end
