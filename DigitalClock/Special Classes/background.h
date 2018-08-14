//
//  background.h
//  DigitalClock
//
//  Created by Cristian Molina on 8/3/18.
//  Copyright © 2018 Cristian Molina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface background : UIView
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *currentBackground;

//functions
- (void)nextPick:(BOOL)s;
- (void)prepareCurrentImage;

@end
