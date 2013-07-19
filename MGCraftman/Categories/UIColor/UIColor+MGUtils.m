//
//  UIColor+MGUtils.m
//  
//
//  Created by Gio on 19/07/2013.
//
//

#import "UIColor+MGUtils.h"

@implementation UIColor (MGUtils)

+ (UIColor *)colorWithIntegerRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(CGFloat)red / 255.0
                           green:(CGFloat)green / 255.0
                            blue:(CGFloat)blue / 255.0
                           alpha:alpha];
}

- (UIColor *)colorByDarkeningColor:(CGFloat)percentage
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

@end
