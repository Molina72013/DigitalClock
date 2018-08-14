//
//  background.m
//  DigitalClock
//
//  Created by Cristian Molina on 8/3/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import "background.h"





@implementation background
{
    NSMutableArray* _image;
    unsigned int _currentIndexx;
}

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
    
    [[NSBundle mainBundle] loadNibNamed:@"background" owner:self options:nil];

    [self addSubview:self.mainView];
    self.mainView.frame = self.bounds;
    [self createImages];
    [self prepareCurrentImage];
}


                                    //Swipe Right and Swipe Left
-(void)nextPick:(BOOL)s
{
    if(s)
    {
        if(_currentIndexx < 9)
        {
            _currentIndexx++;
            _currentBackground.image =  [_image objectAtIndex:_currentIndexx];
            
        } else
        {
            _currentIndexx = 0;
            _currentBackground.image =  [_image objectAtIndex:_currentIndexx];
        }
    } else
    {
        if (_currentIndexx >= 1 && _currentIndexx <=9)
        {
            _currentIndexx--;
            _currentBackground.image =  [_image objectAtIndex:_currentIndexx];
        } else
        {
            _currentIndexx = 9;
            _currentBackground.image =  [_image objectAtIndex:_currentIndexx];

        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:_currentIndexx] forKey:@"digiback"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



                            //Get image for key@"digiback" and load it!
- (void)prepareCurrentImage
{
    NSNumber *savedNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"digiback"];
    if (savedNo == nil)
    {
        savedNo  = @0;
    }
    _currentIndexx = savedNo.intValue;
    _currentBackground.image = [_image objectAtIndex:_currentIndexx];
}



                        //Initialize the array and add the images
-(void) createImages
{
    _image = [NSMutableArray new];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-1"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-2"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-3"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-4"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-5"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-6"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-7"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-8"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-9"]];
    [_image addObject:[UIImage imageNamed:@"img-clock-background-10"]];
    
}


//END
@end
