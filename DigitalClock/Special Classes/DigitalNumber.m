//
//  DigitalNumber.m
//  DigitalClock
//
//  Created by Cristian Molina on 8/1/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import "DigitalNumber.h"
#import "ViewController.h"
static NSString* greenColor = @"green";
static NSString* redColor = @"red";
static NSString* purpleColor = @"purple";
static NSString* darkgreenColor = @"darkgreen";

@implementation DigitalNumber

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self customInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self customInit];
    }
    return self;
}

-(void) customInit//Initializer
{
    [[NSBundle mainBundle] loadNibNamed:@"clockdigitt" owner:self options:nil];
    [self addSubview:self.mainView];
    self.mainView.frame = self.bounds;
}


                                    //Set the hidden layers for the digits

-(void) numeralLayer:(unsigned int)n
{
    if(n == 9) {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:1.0];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:0.1];
        [_bottomrightlayer setAlpha:1.0];
    }
    else if(n == 8)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:1.0];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:1.0];
        [_bottomrightlayer setAlpha:1.0];
    }
    else if(n == 7)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:0.1];
        [_middlelayer setAlpha:0.1];
        [_bottomlayer setAlpha:0.1];
        [_bottomleftlayer setAlpha:0.1];
        [_bottomrightlayer setAlpha:1.0];
    }
    
    else if(n == 6)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:0.1];
        [_topleftlayer setAlpha:1.0];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:1.0];
        [_bottomrightlayer setAlpha:1.0];
    } else if (n==5)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:0.1];
        [_topleftlayer setAlpha:1.0];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:0.1];
        [_bottomrightlayer setAlpha:1.0];
    } else if (n==4)
    {
        [_toplayer setAlpha:0.1];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:1.0];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:0.1];
        [_bottomleftlayer setAlpha:0.1];
        [_bottomrightlayer setAlpha:1.0];
    } else if (n==3)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:0.1];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:0.1];
        [_bottomrightlayer setAlpha:1.0];
    } else if (n==2)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:0.1];
        [_middlelayer setAlpha:1.0];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:1.0];
        [_bottomrightlayer setAlpha:0.1];
    } else if (n==1)
    {
        [_toplayer setAlpha:0.1];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:0.1];
        [_middlelayer setAlpha:0.1];
        [_bottomlayer setAlpha:0.1];
        [_bottomleftlayer setAlpha:0.1];
        [_bottomrightlayer setAlpha:1.0];
    }else if (n==0)
    {
        [_toplayer setAlpha:1.0];
        [_toprightlayer setAlpha:1.0];
        [_topleftlayer setAlpha:1.0];
        [_middlelayer setAlpha:0.1];
        [_bottomlayer setAlpha:1.0];
        [_bottomleftlayer setAlpha:1.0];
        [_bottomrightlayer setAlpha:1.0];
    }
}



                                        //Gets the digit for Single/Double Digit, thenrun the numberLayer()
-(void) getSingleDigitFor:(unsigned int)n
{
    int doubleDigit;
    doubleDigit = n % 10;// Divide by 10, give me the remainder
    [self numeralLayer:doubleDigit];
}

-(void) getDoubleDigitFor:(unsigned int)n
{
    int singleDigit;
    singleDigit = n / 10;//Gives me the double digit value.
    [self numeralLayer:singleDigit];
}




                                    //Change the UIView background based on colors
-(void) changeLayerColor:(NSString*)s
{
    UIColor* green = [UIColor colorWithRed:(7.0 / 255.0) green:(245.0 / 255.0)
                                      blue:(62.0 / 255.0) alpha: 1];
    UIColor* red = [UIColor colorWithRed:(254.0 / 255.0) green:(0.0 / 255.0)
                                    blue:(0.0 / 255.0) alpha: 1];
    UIColor* purple = [UIColor colorWithRed:(67.0 / 255.0) green:(126.0 / 255.0)
                                       blue:(243.0 / 255.0) alpha: 1];
    UIColor* darkgreen = [UIColor colorWithRed:(53.0 / 255.0) green:(155.0 / 255.0)
                                          blue:(93.0 / 255.0) alpha: 1];
    
    if([s isEqualToString:@"green"])
    {
        [_toplayer setBackgroundColor:green];
        [_toprightlayer setBackgroundColor:green];
        [_topleftlayer setBackgroundColor:green];
        [_middlelayer setBackgroundColor:green];
        [_bottomlayer setBackgroundColor:green];
        [_bottomleftlayer setBackgroundColor:green];
        [_bottomrightlayer setBackgroundColor:green];
    } else if([s isEqualToString:@"red"])
    {
        [_toplayer setBackgroundColor:red];
        [_toprightlayer setBackgroundColor:red];
        [_topleftlayer setBackgroundColor:red];
        [_middlelayer setBackgroundColor:red];
        [_bottomlayer setBackgroundColor:red];
        [_bottomleftlayer setBackgroundColor:red];
        [_bottomrightlayer setBackgroundColor:red];
    } else if([s isEqualToString:@"purple"])
    {
        [_toplayer setBackgroundColor:purple];
        [_toprightlayer setBackgroundColor:purple];
        [_topleftlayer setBackgroundColor:purple];
        [_middlelayer setBackgroundColor:purple];
        [_bottomlayer setBackgroundColor:purple];
        [_bottomleftlayer setBackgroundColor:purple];
        [_bottomrightlayer setBackgroundColor:purple];
    } else if([s isEqualToString:@"darkgreen"])
    {
        [_toplayer setBackgroundColor:darkgreen];
        [_toprightlayer setBackgroundColor:darkgreen];
        [_topleftlayer setBackgroundColor:darkgreen];
        [_middlelayer setBackgroundColor:darkgreen];
        [_bottomlayer setBackgroundColor:darkgreen];
        [_bottomleftlayer setBackgroundColor:darkgreen];
        [_bottomrightlayer setBackgroundColor:darkgreen];
    }
    
}

//END
@end
