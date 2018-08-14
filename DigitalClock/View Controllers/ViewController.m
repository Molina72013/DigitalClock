//
//  ViewController.m
//  DigitalClock
//
//  Created by Cristian Molina on 7/31/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import "ViewController.h"
#import "DigitalNumber.h"
#import "background.h"
#import "SettingsViewController.h"



static NSString* greenColor = @"green";
static NSString* redColor = @"red";
static NSString* purpleColor = @"purple";
static NSString* darkgreenColor = @"darkgreen";
@interface ViewController ()


@end

@implementation ViewController 
{
   // NSDateFormatter for NSDate value
    NSDateFormatter* seconds;
    NSDateFormatter* hours;
    NSDateFormatter* minutes;
    NSString* currentTimeZone;
    BOOL militaryOrNot;
    int currentColor;
    BOOL checkingScreentap;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetLabels];//start timer
}

-(void) resetLabels
{
    seconds = [[NSDateFormatter alloc] init];
    [seconds setDateFormat:@"ss"];
    minutes = [[NSDateFormatter alloc] init];
    [minutes setDateFormat:@"mm"];
    hours = [[NSDateFormatter alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(targetMethod:)
                                   userInfo:nil
                                    repeats:YES];
}


-(void) targetMethod:(id)sender
{
    [self checkDataAndAM];
    [self checkIfMilitaryTime];

    [seconds setTimeZone:[NSTimeZone timeZoneWithName:currentTimeZone]];     // time zoneeeee store it in a var
    [minutes setTimeZone:[NSTimeZone timeZoneWithName:currentTimeZone]];
    [hours setTimeZone:[NSTimeZone timeZoneWithName:currentTimeZone]];

    
    NSString *currentSecond = [seconds stringFromDate: [NSDate date]];
    NSString *currentMinute = [minutes stringFromDate: [NSDate date]];
    NSString *currentHour = [hours stringFromDate: [NSDate date]];

    //get layers digits for values
    [self secondsBlinker:currentSecond];
    
    //LAYER COLOR


    [_secondsSingleDigit getSingleDigitFor:[currentSecond intValue]];
    [_secondsDoubleDigit getDoubleDigitFor:[currentSecond intValue]];
    [_minuteSingleDigit getSingleDigitFor:[currentMinute intValue]];
    [_minuteDoubleDigit getDoubleDigitFor:[currentMinute intValue]];
    [_hourSingleDigit getSingleDigitFor:[currentHour intValue]];
    [_hourDoubleDigit getDoubleDigitFor:[currentHour intValue]];

}




- (IBAction)showSettings:(id)sender
{
    [self performSegueWithIdentifier:@"settings" sender:sender];
}


                                //Swipe LEFT/RIGHT
- (IBAction)NextPicture:(id)sender
{
    NSLog(@"Swiped Right");
    [_mainBackground nextPick:false];
}

- (IBAction)prePic:(id)sender {
    [_mainBackground nextPick:true];
}


                            //Blinker for the seconds
-(void) secondsBlinker:(NSString*)i
{
    if ([i intValue] % 2 == 0)
    {
        for (id i in _dots)
        {
            [i setAlpha:0.1];
        }
    } else
    {
        for (id i in _dots)
        {
            [i setAlpha:1.0];
        }
    }
}


                                //Hide Status Bar
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)alphaForButton:(id)sender
{
    if(!checkingScreentap)
    {
        checkingScreentap = true;
        _settingButton.hidden = !_settingButton.hidden;
        
        double delayInSeconds = 8.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self->_settingButton.hidden = !self->_settingButton.hidden;
            self->checkingScreentap = false;
        });
        
    }

}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"settings"])
    {
        SettingsViewController *settings = [segue destinationViewController];
        
        [settings setmainViewImage: _mainBackground.currentBackground.image];
        
        
    }
}


-(void)viewWillAppear:(BOOL)animated{

    NSString* savedZone = [[NSUserDefaults standardUserDefaults] objectForKey:@"timezone"];
    if (savedZone == nil)
    {
        savedZone  = @"CMT";
    }
    currentTimeZone = savedZone;
    NSLog(@"viewDidAppear");
    [self setColorSway];
    [self checkIfMilitaryTime];
    _settingButton.hidden = true;


    
}


-(void) setColorSway
{
    NSNumber* colorindex = [[NSUserDefaults standardUserDefaults] objectForKey:@"savedcolor"];
    if(!colorindex)
    {
        colorindex = @1;
    }
        
    
    currentColor = colorindex.intValue;
    
    NSString* currColor = [NSString new];
    
    if(currentColor == 1)
    {
        currColor = @"green";
    } else if (currentColor == 2)
    {
        currColor = @"red";
    } else if (currentColor == 3)
    {
        currColor = @"purple";
    } else if (currentColor == 4)
    {
        currColor = @"darkgreen";
    }


    
    
    [_secondsSingleDigit changeLayerColor:currColor];
    [_secondsDoubleDigit changeLayerColor:currColor];
    [_minuteSingleDigit changeLayerColor:currColor];
    [_minuteDoubleDigit changeLayerColor:currColor];
    [_hourSingleDigit changeLayerColor:currColor];
    [_hourDoubleDigit changeLayerColor:currColor];
    
    for (id i in _dots)
    {
        [i setBackgroundColor: _hourSingleDigit.toplayer.backgroundColor];
    }

    for (UILabel* i in _AMPM)
    {
        i.textColor = _hourSingleDigit.toplayer.backgroundColor;
    }
    
    _dateLabel.textColor = _hourSingleDigit.toplayer.backgroundColor;
 
    
}

-(void) checkIfMilitaryTime
{
    BOOL hourFrame = [[NSUserDefaults standardUserDefaults] boolForKey:@"pmam"];
    militaryOrNot = hourFrame;
    
    if (militaryOrNot)
    {
        [hours setDateFormat:@"HH"];
    } else
    {
        [hours setDateFormat:@"hh"];
    }
    
}


-(void) checkDataAndAM
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE MMMM dd"]; //HH for military
    NSString* currentTime = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:currentTimeZone]]; 
    _dateLabel.text = currentTime;
    
    
    NSDateFormatter *ampm = [[NSDateFormatter alloc] init];
    
    [ampm setDateFormat:@"aa"];
    
    NSString* ampmString = [NSString stringWithFormat:@"%@", [ampm stringFromDate:[NSDate date]]];
    [ampm setTimeZone:[NSTimeZone timeZoneWithName:currentTimeZone]];
                             
    for (UILabel* i in _AMPM)
    {
        if([ampmString isEqualToString:@"AM"])
        {
            UILabel* am = [i viewWithTag:2];
            
            [am setAlpha:0.1];
            continue;
            
        } else if([ampmString isEqualToString:@"PM"])
        {
            UILabel* pm = [i viewWithTag:1];
            
            [pm setAlpha:0.1];
            continue;
        }
        
        [i setAlpha:1.0];
            
    }

}


@end








