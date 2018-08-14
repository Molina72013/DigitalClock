//
//  SettingsViewController.h
//  DigitalClock
//
//  Created by Cristian Molina on 8/6/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *settingsBackground;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UISwitch *hourSlider;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UIButton *redbutton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorButtons;


//functions
- (IBAction)dissMissSettings:(id)sender;
- (IBAction)militaryTime:(id)sender;
- (IBAction) chooseColor:(UIButton*)sender;
-(void)setmainViewImage:(UIImage*)i;

@end
