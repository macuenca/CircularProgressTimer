//
//  MainViewController.h
//  CircularProgressTimer
//
//  Created by mc on 6/30/13.
//  Copyright (c) 2013 mauricio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressTimer.h"

@interface MainViewController : UIViewController
{
    NSTimer *timer;
    NSInteger globalTimer;
    NSInteger counter;
    NSInteger minutesLeft;
    NSInteger secondsLeft;
    UIRefreshControl *refreshControl;
    CircularProgressTimer *progressTimerView;
}

@end
