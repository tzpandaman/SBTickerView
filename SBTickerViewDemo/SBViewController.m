//
//  SBViewController.m
//  SBTickerViewDemo
//
//  Created by Simon Blommegård on 2011-12-10.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import "SBViewController.h"
#import "SBTickerView.h"
#import "SBTickView.h"

@implementation SBViewController

@synthesize fullTickerView;
@synthesize imageTickerView;
@synthesize clockTickerViewHour1;
@synthesize clockTickerViewHour2;
@synthesize clockTickerViewMinute1;
@synthesize clockTickerViewMinute2;
@synthesize clockTickerViewSecond1;
@synthesize clockTickerViewSecond2;

@synthesize frontView;
@synthesize backView;

@synthesize hours;
@synthesize minutes;
@synthesize seconds;

@synthesize timer;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [fullTickerView setFrontView:frontView];
    [fullTickerView setBackView:backView];
//    [fullTickerView setDuration:1.];
    [fullTickerView setPanning:YES];
    [fullTickerView setAllowedPanDirections:(SBTickerViewAllowedPanDirectionDown | SBTickerViewAllowedPanDirectionUp)];
    
    [imageTickerView setFrontView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"front.jpeg"]]];
    [imageTickerView setBackView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.jpeg"]]];
    
    //RX calls the function called "Count down" every second
    NSLog(@"here at count down");

    //RX sets the timer to true and it will be false when hour is wual to 0
    self.timer = TRUE;
    if(self.timer){
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
    
    //Init
    _currentClock = @"000000";//RX if this is set to 000000 then the ticker view starts with curretn date

    _clockTickers = [NSArray arrayWithObjects:
                     clockTickerViewHour1,
                     clockTickerViewHour2,
                     clockTickerViewMinute1,
                     clockTickerViewMinute2,
                     clockTickerViewSecond1,
                     clockTickerViewSecond2, nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HHmmss"];
    
    
    
    //RX The Start Date
    NSDate *pastDate = [formatter dateFromString:@"2013-06-05 104315"];
    //RX The End Date
    NSDate *recentDate = [formatter dateFromString:@"2013-10-06 201020"];
    
    
    
    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //RX gets the calender units for the differences
    NSUInteger unitFlags =  NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *componentsDaysDiff = [calendar components:unitFlags
                                                       fromDate:pastDate
                                                         toDate:recentDate
                                                        options:0];
    
    self.hours = [componentsDaysDiff hour];
    self.minutes = [componentsDaysDiff minute];
    self.seconds = [componentsDaysDiff second];
    
    NSString *hourStr = [NSString stringWithFormat:@"%d", self.hours];
    NSString *minuteStr = [NSString stringWithFormat:@"%d", self.minutes];
    NSString *secondStr = [NSString stringWithFormat:@"%d", self.seconds];
    NSLog(@"hour %i",hourStr.length);
    NSLog(@"minute %i",minuteStr.length);
    NSLog(@"second %i",secondStr.length);
    
    for(int i = 0;i < _clockTickers.count;i++){
        switch (i) {
            case 0:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(0, 1)] fontSize:45.]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:45.]];  
                     NSLog(@"1");
                }
                break;
            case 1:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(1, 1)] fontSize:45.]];
                     NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:hourStr fontSize:45.]];  
                     NSLog(@"2");
                }
                break;
            case 2:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(0, 1)] fontSize:45.]];
                     NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:45.]];
                     NSLog(@"1");
                }
                break;
            case 3:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(1, 1)] fontSize:45.]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:minuteStr fontSize:45.]];
                }

                break;
            case 4:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(0, 1)] fontSize:45.]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:45.]];
                }
                break;
            case 5:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(1, 1)] fontSize:45.]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:secondStr fontSize:45.]];
                }
                break;
                
            default:
                break;
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)tick:(UIButton *)sender {
    if (sender.tag == 0 || sender.tag == 1)
        [imageTickerView tick:sender.tag animated:YES completion:^{
            NSLog(@"Done Down");
        }];
    
    else {
        [fullTickerView tick:(sender.tag - 2) animated:YES completion:nil];
    }
}

-(void)countDown:(id)sender{
    NSLog(@"ticking");
    
    if (self.seconds != 0) {
        self.seconds--;
    } else {
        self.seconds = 60;
        if (self.minutes != 0) {
            self.minutes--;
        } else {
            self.minutes = 60;
            if (self.hours != 0) {
                self.hours --;
            } else {
                
                //** This is the end of the timer: Do something AND stop calling this function **//
                
                self.timer = FALSE;
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Times up baby" message:@"Time!! Time!!" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"cancel", nil];
                [alert show];
            }
        }
    }
    

    NSString *hourStr = [NSString stringWithFormat:@"%d", self.hours];
    NSString *minuteStr = [NSString stringWithFormat:@"%d", self.minutes];
    NSString *secondStr = [NSString stringWithFormat:@"%d", self.seconds];

    for(int i = 0;i < _clockTickers.count;i++){
        switch (i) {
            case 0:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(0, 1)] fontSize:45.]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:45.]];
                    NSLog(@"1");
                }
                break;
            case 1:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(1, 1)] fontSize:45.]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:hourStr fontSize:45.]];
                    NSLog(@"2");
                }
                break;
            case 2:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(0, 1)] fontSize:45.]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:45.]];
                    NSLog(@"1");
                }
                break;
            case 3:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(1, 1)] fontSize:45.]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:minuteStr fontSize:45.]];
                }
                
                break;
            case 4:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(0, 1)] fontSize:45.]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:45.]];
                }
                break;
            case 5:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(1, 1)] fontSize:45.]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:secondStr fontSize:45.]];
                }
                break;
                
            default:
                break;
        }
    }
    
}

- (void)numberTick:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSString *newClock = [formatter stringFromDate:[NSDate date]];
        
    [_clockTickers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"currentClock: %@ // newClock %@",[_currentClock substringWithRange:NSMakeRange(idx, 1)],[newClock substringWithRange:NSMakeRange(idx, 1)] );
        if (![[_currentClock substringWithRange:NSMakeRange(idx, 1)] isEqualToString:[newClock substringWithRange:NSMakeRange(idx, 1)]]) {
            NSLog(@"index: %i",idx);
            [obj setBackView:[SBTickView tickViewWithTitle:[newClock substringWithRange:NSMakeRange(idx, 1)] fontSize:45.]];
            NSLog(@"new clock: %@",[newClock substringWithRange:NSMakeRange(idx, 1)]);
            [obj tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
            NSLog(@"Ticking");
        }
    }];
    
    _currentClock = newClock;
}

@end
