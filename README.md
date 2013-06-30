CircularProgressTimer
=====================

Circular Progress Timer working demo in Objective-C for iOS 6+

This is my take on a control that is getting too mainstream :)
Is a snippet of what I used on the [Madrid Bus App](http://madridbus.co/):

![Component screenshot](http://f.cl.ly/items/1N1h153u1N0e0Z38432M/CircularProgressBar.png)

The project uses Interface Builder only for the main View Controller, but the circular progress view is built programatically.

No extra frameworks needed, just UIKit.

1. Copy and paste CircularProgressBarView header and implementation files into your project. Don't forget the circle.png and circle@2x.png files.
2. Kick-off a timer with a one second interval whose action points to the progress bar drawing method. You can see the full example in MainViewController.m:


```objective-c
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(updateCircularProgressBar)
                                           userInfo:nil
                                            repeats:YES];

```


3. In the updateCircularProgressBar method, just call the drawing function passing the total amount of seconds left. Show the remaining amount of time in minutes and seconds is a simple operation:


```objective-c
        minutesLeft = globalTimer / 60;
        secondsLeft = globalTimer % 60;
    
        [self drawCircularProgressBarWithMinutesLeft:minutesLeft secondsLeft:secondsLeft]
```
