//
//  UIColor+MGUtils.h
//  
//
//  Created by Gio on 19/07/2013.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (MGUtils)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red
                           green:(NSUInteger)green
                            blue:(NSUInteger)blue
                           alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithAlpha:(BOOL)withAlpha;

// See http://www.cocoanetics.com/2009/10/manipulating-uicolors/
- (UIColor *)darkenedColor:(CGFloat)percentage;
- (UIColor *)darkenedColor;

@end
