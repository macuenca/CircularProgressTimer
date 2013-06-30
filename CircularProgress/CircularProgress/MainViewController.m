//
//  MainViewController.m
//  CircularProgressTimer
//
//  Created by mc on 6/30/13.
//  Copyright (c) 2013 mauricio. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    globalTimer = 600;
    [self startTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Draws the progress circles on top of the already painted backgroud
- (void)drawCircularProgressBarWithMinutesLeft:(NSInteger)minutes secondsLeft:(NSInteger)seconds
{
    // Removing unused view to prevent them from stacking up
    for (id subView in [self.view subviews]) {
        if ([subView isKindOfClass:[CircularProgressTimer class]]) {
            [subView removeFromSuperview];
        }
    }
    
    // Init our view and set current circular progress bar value
    CGRect progressBarFrame = CGRectMake(0, 0, 180, 180);
    progressTimerView = [[CircularProgressTimer alloc] initWithFrame:progressBarFrame];
    [progressTimerView setCenter:CGPointMake(160, 210)];
    [progressTimerView setPercent:seconds];
    if (minutes == 0 && seconds == 0) {
        [progressTimerView setInstanceColor:[UIColor redColor]];
    }
    
    // Here, setting the minutes left before adding it to the parent view
    [progressTimerView setMinutesLeft:minutesLeft];
    [progressTimerView setSecondsLeft:secondsLeft];
    [self.view addSubview:progressTimerView];
    progressTimerView = nil;
}

- (void)startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateCircularProgressBar)
                                           userInfo:nil
                                            repeats:YES];
}

- (void)updateCircularProgressBar
{
    // Values to be passed on to Circular Progress Bar
    if (globalTimer > 0 && globalTimer <= 1200) {
        globalTimer--;
        minutesLeft = globalTimer / 60;
        secondsLeft = globalTimer % 60;
        
        [self drawCircularProgressBarWithMinutesLeft:minutesLeft secondsLeft:secondsLeft];
        NSLog(@"Time left: %02d:%02d", minutesLeft, secondsLeft);
    } else {
        [self drawCircularProgressBarWithMinutesLeft:0 secondsLeft:0];
        [timer invalidate];
    }
}

@end
