//
//  ViewController.m
//  RandomColors
//
//  Created by Giovanni Lodi on 1/20/13.
//  Copyright (c) 2013 mokagio. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+CSSColors.h"

@interface ViewController ()
- (void)randomlyChangeColor;
- (BOOL)isColor:(UIColor *)testedColor equalToColor:(UIColor *)testColor;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[self getRandomColor]];

    UITapGestureRecognizer *tapHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(randomlyChangeColor)];
    [self.view addGestureRecognizer:tapHandler];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)randomlyChangeColor
{
    UIColor *color = [self getRandomColor];
    
    // we don't want to have the same color twice in a row
    while ([self isColor:color equalToColor:self.view.backgroundColor]) {
        color = [self getRandomColor];
    }
    
    [self.view setBackgroundColor:color];
}

- (UIColor *)getRandomColor
{
    
    int random = arc4random() % 6;
    
    UIColor *color = nil;
    
    switch (random) {
        case 0:
            color = [UIColor lightSeaGreenColor];
            break;
        case 1:
            // dunno why, but indianRedColor reminds me of Assassin's Creed Brotherhood
            color = [UIColor indianRedColor];
            break;
        case 2:
            color = [UIColor yellowGreenColor];
            break;
        case 3:
            color = [UIColor gainsboroColor];
            break;
        case 4:
            color = [UIColor midnightBlueColor];
            break;
        case 5:
            color = [UIColor orchidColor];
            break;
        default:
            color = [UIColor ghostWhiteColor];
            break;
    }
    
    return color;
}

- (BOOL)isColor:(UIColor *)testedColor equalToColor:(UIColor *)testColor
{
    CGFloat testedRed, testedGreen, testedBlue, testedAlpha;
    CGFloat testRed, testGreen, testBlue, testAlpha;
    
    [testedColor getRed:&testedRed green:&testedGreen blue:&testedBlue alpha:&testedAlpha];
    [testColor getRed:&testRed green:&testGreen blue:&testBlue alpha:&testAlpha];
    
    BOOL isRedEqual = testedRed == testedRed;
    BOOL isGreenEqual = testedGreen == testGreen;
    BOOL isBlueEqual = testedBlue == testBlue;
    BOOL isAlphaEqual = testedAlpha == testAlpha;
    
    return isRedEqual && isGreenEqual && isBlueEqual && isAlphaEqual;
}

@end
