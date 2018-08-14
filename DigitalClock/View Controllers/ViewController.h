//
//  ViewController.h
//  DigitalClock
//
//  Created by Cristian Molina on 7/31/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DigitalNumber.h"
#import "background.h"


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet DigitalNumber *secondsSingleDigit;
@property (weak, nonatomic) IBOutlet DigitalNumber *secondsDoubleDigit;
@property (weak, nonatomic) IBOutlet DigitalNumber *minuteSingleDigit;
@property (weak, nonatomic) IBOutlet DigitalNumber *minuteDoubleDigit;
@property (weak, nonatomic) IBOutlet DigitalNumber *hourSingleDigit;
@property (weak, nonatomic) IBOutlet DigitalNumber *hourDoubleDigit;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *dots;
@property (weak, nonatomic) IBOutlet background *mainBackground;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *AMPM;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

//Functions
- (IBAction)showSettings:(id)sender;
- (IBAction)NextPicture:(id)sender;
- (IBAction)prePic:(id)sender;
- (IBAction)alphaForButton:(id)sender;

@end

