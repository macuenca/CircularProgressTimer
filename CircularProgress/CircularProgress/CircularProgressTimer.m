//
//  CircularProgressTimer.m
//  CircularProgressTimer
//
//  Created by mc on 6/30/13.
//  Copyright (c) 2013 mauricio. All rights reserved.
//

#import "CircularProgressTimer.h"

@implementation CircularProgressTimer

@synthesize instanceColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setup];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Allowing to change the circle color at runtime
    UIColor *color;
    if (!instanceColor) {
        color = [UIColor colorWithRed:0.86f green:0.86f blue:0.86f alpha:1.00f];
    } else {
        color = instanceColor;
    }
    
    // Gray static circle in the background, set to Red when there's no time left
    UIBezierPath *marginCircle = [UIBezierPath bezierPath];
    [marginCircle addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                            radius:78
                        startAngle:0
                          endAngle:2 * M_PI
                         clockwise:YES];
    marginCircle.lineWidth = 20;
    [color setStroke];
    [marginCircle stroke];
    
    // Create our arc, with the correct angles
    // The initialAngleFactor is the extra angular distance the stroke will cover from
    // angle zero to the desired initial angle. For example, if you want it to start from
    // angle zero, the factor will be zero. In this case, we'll start from 12 o'clock,
    // which is angle 3M_PI/2 or 1.5M_PI
    float initialAngleFactor = 1.5 * M_PI;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:80
                      startAngle:0 + initialAngleFactor
                        endAngle:(_percent * M_PI) / 30.0 + initialAngleFactor
                       clockwise:YES];
    
    // Are you wondering where the previous formula comes from?
    // (_percent * M_PI) / 30.0 + initialAngleFactor
    // Well, M_PI covers just half of the circle, which can display as much as 30 seconds.
    // That's the number of pieces in which the half circle is divided: 30 on each piece.
    bezierPath.lineWidth = 14;
    [[UIColor colorWithRed:0.03f green:0.64f blue:0.83f alpha:1.00f] setStroke];
    [bezierPath stroke];
    
    // The big main number in the center of the circle
    UILabel *minuteCounterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [minuteCounterLabel setCenter:CGPointMake(90, 80)];
    [minuteCounterLabel setBackgroundColor:[UIColor clearColor]];
    [minuteCounterLabel setTextColor:[UIColor blackColor]];
    [minuteCounterLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:70]];
    if (_minutesLeft > 0) {
        [minuteCounterLabel setText:[NSString stringWithFormat:@"%d", _minutesLeft]];
    } else {
        [minuteCounterLabel setText:[NSString stringWithFormat:@"%d", _secondsLeft]];
    }
    [minuteCounterLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:minuteCounterLabel];
    minuteCounterLabel = nil;
    
    // Small label that display minutes or seconds right below the big number
    UILabel *minutesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 14)];
    [minutesLabel setCenter:CGPointMake(90, 120)];
    [minutesLabel setBackgroundColor:[UIColor clearColor]];
    [minutesLabel setTextColor:[UIColor blackColor]];
    [minutesLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:12]];
    NSString *minutesTextLabel = @"minutes";
    if (!_minutesLeft) {
        minutesTextLabel = @"seconds";
    }
    
    // Singular only for "1 minute"
    if (_minutesLeft > 0 && _minutesLeft < 2) {
        minutesTextLabel = @"minute";
    }
    
    [minutesLabel setText:minutesTextLabel];
    [minutesLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:minutesLabel];
    minutesLabel = nil;
}

- (void)setup
{
    UIImageView *circularBackground = [[UIImageView alloc] initWithFrame:self.bounds];
    circularBackground.image = [UIImage imageNamed:@"circle"];
    [self addSubview:circularBackground];
}

@end
