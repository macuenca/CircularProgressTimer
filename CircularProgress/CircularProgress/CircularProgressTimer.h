//
//  CircularProgressTimer.h
//  CircularProgressTimer
//
//  Created by mc on 6/30/13.
//  Copyright (c) 2013 mauricio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressTimer : UIView
{
    CGFloat startAngle;
    CGFloat endAngle;
}

@property (nonatomic) NSInteger percent;
@property (nonatomic) NSInteger minutesLeft;
@property (nonatomic) NSInteger secondsLeft;
@property (weak, nonatomic) UIColor *instanceColor;

@end
