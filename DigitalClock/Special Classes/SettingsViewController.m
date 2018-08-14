//
//  SettingsViewController.m
//  DigitalClock
//
//  Created by Cristian Molina on 8/6/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import "SettingsViewController.h"
#import "background.h"
#import "DigitalNumber.h"



@interface SettingsViewController ()

@end

@implementation SettingsViewController
{
    UIImage* mainViewImage;
    NSArray* _pickerData;
    NSString* timeZoneInitals;
    int currentRowOnPicker;
    BOOL settingMilHr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNCreate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setmainViewImage:(UIImage*)i
{
    mainViewImage = i;
}

- (IBAction)dissMissSettings:(id)sender
{
    if (timeZoneInitals)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", timeZoneInitals] forKey:@"timezone"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) createData
{
    //_pickerData = @[@"1", @"2", @"3", @"4"];
    _pickerData = @[@"Eastern Standard Time",//EST
                    @"Atlantic Standard Time", //AST
                    @"Eastern Daylight Time",//EDT
                    @"Pasific Standard Time",// PST
                    @"Central Standard Time"];//CST
    
}


- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
  
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}


- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = _pickerData[row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}







-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString* chosenData = [_pickerData objectAtIndex:row];
    timeZoneInitals = [self returnInitail:chosenData];
    currentRowOnPicker = (int)[_pickerData indexOfObject:_pickerData[row]];  // <-- get the row for the selected item
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:currentRowOnPicker] forKey:@"saveindex"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}


-(NSString*) returnInitail:(NSString*)s
{
    NSArray* charatcters = [s componentsSeparatedByString:@" "];
    NSString* initails = @"";
    for (id i in charatcters)
    {
        NSString* firstChar = [i substringToIndex:1];
        //NSLog(@"%@",firstChar);
        initails = [initails stringByAppendingString: firstChar];
    }
    
    NSLog(@"%@",initails);
    return initails;
    
}



- (IBAction) chooseColor:(UIButton*)sender
{
    NSLog(@"you clicked on the button with the tag %ld", sender.tag);
    for(UIButton* i in _colorButtons)
    {
        if (i == sender) {              // <--- seleceted color
            i.selected = YES;
            [i setAlpha:0.5];
            [self saveTheChosenColor:i];
            continue;
        }
        i.selected = NO;
        [i setAlpha:0.9];
    }
}



                            //gets the index stored in key@"savedindex" and sets the pickers current index
- (void)prepareCurrentIndex//Load
{
    NSNumber *savedNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"saveindex"];
    if (savedNo == nil)
    {
        savedNo  = @1;
    }
    currentRowOnPicker = savedNo.intValue;
    [_picker selectRow:currentRowOnPicker inComponent:0 animated:YES];

}


                                //makes the saved index select the current color
-(void)prepareForColor
{
    for (UIButton* i in _colorButtons)
    {
        if(i.tag == currentRowOnPicker)
        {
            i.selected = YES;
            [i setAlpha:0.5];
            continue;
        }
    }
}


//                                                  Saves the current selected color
-(void) saveTheChosenColor:(UIButton*)s
{
    NSUInteger saveColor = s.tag;
    
    
    NSLog(@"%ld",saveColor);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:saveColor] forKey:@"savedcolor"];// saved the current button tag
    [[NSUserDefaults standardUserDefaults] synchronize];

}


                                    //Creates the chosen color and checks for nil
-(void) getChosenColorr
{
    NSNumber* chonsenColor = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedcolor"];
    if(!chonsenColor)
    {
        chonsenColor = @1;
    }
    
    currentRowOnPicker = chonsenColor.intValue;
}


                                        //turns on military time and saves the status as a BOOL
- (IBAction)militaryTime:(id)sender
{
    if ([_hourSlider isOn]) {
        NSLog(@"military time is  on!");
        settingMilHr = YES;

    } else {
        NSLog(@"military time is off!");
        settingMilHr = NO;
    }
    NSLog(@"happens either way");
    [[NSUserDefaults standardUserDefaults] setBool:settingMilHr forKey:@"pmam"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




                            //Loads the switch to see if it should be ON/OFF
-(void) checkSlider
{
    BOOL presentosHours = [[NSUserDefaults standardUserDefaults] boolForKey:@"pmam"];
    settingMilHr = presentosHours;
    
    if (!settingMilHr)
    {
        [_hourSlider setOn:false];
    } else
    {
        [_hourSlider setOn:true];
    }
    
}


                                //Hide the status bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}



                                //What should hapeen in viewDidLoad()
-(void) loadNCreate
{
    _settingsBackground.image = mainViewImage;
    //Picker data and delegates and picker's current index
    [self createData];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [self prepareCurrentIndex];
  
    //Load up the color from key@"savedcolor" and present it
    [self getChosenColorr];
    [self prepareForColor];
   
    //Check if slider should be on or off
    [self checkSlider];
    
    //Make the color buttons round circles
    for(UIButton* i in _colorButtons)
    {
        i.clipsToBounds = YES;
        i.layer.cornerRadius = i.layer.frame.size.width/2;
    }
}


@end
