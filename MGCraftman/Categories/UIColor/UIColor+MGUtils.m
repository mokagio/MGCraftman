//
//  UIColor+MGUtils.m
//  
//
//  Created by Gio on 19/07/2013.
//
//

#import "UIColor+MGUtils.h"

static CGFloat kDefaultDarkeningPercentage = 0.85;

@implementation UIColor (MGUtils)

#pragma mark - Color with Integer Component

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red
                           green:(NSUInteger)green
                            blue:(NSUInteger)blue
                           alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(CGFloat)red / 255.0
                           green:(CGFloat)green / 255.0
                            blue:(CGFloat)blue / 255.0
                           alpha:alpha];
}

#pragma mark - Color by modifing existing color

- (UIColor *)darkenedColor:(CGFloat)percentage
{
	// oldComponents is the array INSIDE the original color
	// changing these changes the original, so we copy it
	CGFloat *oldComponents = (CGFloat *)CGColorGetComponents([self CGColor]);
	CGFloat newComponents[4];
    
	int numComponents = CGColorGetNumberOfComponents([self CGColor]);
    
	switch (numComponents)
	{
		case 2:
		{
			//grayscale
			newComponents[0] = oldComponents[0] * percentage;
			newComponents[1] = oldComponents[0] * percentage;
			newComponents[2] = oldComponents[0] * percentage;
			newComponents[3] = oldComponents[1];
			break;
		}
		case 4:
		{
			//RGBA
			newComponents[0] = oldComponents[0] * percentage;
			newComponents[1] = oldComponents[1] * percentage;
			newComponents[2] = oldComponents[2] * percentage;
			newComponents[3] = oldComponents[3];
			break;
		}
	}
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
	return retColor;
}

- (UIColor *)darkenedColor
{
    return [self darkenedColor:kDefaultDarkeningPercentage];
}

#pragma mark - Random Color

+ (UIColor *)randomColor
{
    return [self randomColorWithAlpha:NO];
}

+ (UIColor *)randomColorWithAlpha:(BOOL)withAlpha
{
    CGFloat red = arc4random() % 256;
    red /= 255;
    
    CGFloat green = arc4random() % 256;
    green /= 255;
    
    CGFloat blue = arc4random() % 256;
    blue /= 255;
    
    CGFloat alpha;
    if (withAlpha) {
        alpha = arc4random() % 101;
        alpha /= 100;
    } else {
        alpha = 1.0;
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
