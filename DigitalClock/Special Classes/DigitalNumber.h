//
//  DigitalNumber.h
//  DigitalClock
//
//  Created by Cristian Molina on 8/1/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DigitalNumber : UIView
@property (strong, nonatomic) IBOutlet UIView *mainView;
//The layers of a digit #8
@property (weak, nonatomic) IBOutlet UIView *toplayer;
@property (weak, nonatomic) IBOutlet UIView *bottomrightlayer;
@property (weak, nonatomic) IBOutlet UIView *topleftlayer;
@property (weak, nonatomic) IBOutlet UIView *bottomlayer;
@property (weak, nonatomic) IBOutlet UIView *toprightlayer;
@property (weak, nonatomic) IBOutlet UIView *middlelayer;
@property (weak, nonatomic) IBOutlet UIView *bottomleftlayer;


//functions
-(void) numeralLayer:(unsigned int)n;
-(void) getSingleDigitFor:(unsigned int)n;
-(void) getDoubleDigitFor:(unsigned int)n;
-(void) changeLayerColor:(NSString*)s;
//+(UIColor*) getColor:(NSString*)s;



@end
