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


//RX defines font size;
#define FONT_SIZE 20

@implementation SBViewController

@synthesize fullTickerView;
@synthesize imageTickerView;
@synthesize clockTickerViewWeek1;
@synthesize clockTickerViewWeek2;
@synthesize clockTickerViewDay1;
@synthesize clockTickerViewDay2;
@synthesize clockTickerViewHour1;
@synthesize clockTickerViewHour2;
@synthesize clockTickerViewMinute1;
@synthesize clockTickerViewMinute2;
@synthesize clockTickerViewSecond1;
@synthesize clockTickerViewSecond2;

@synthesize frontView;
@synthesize backView;

@synthesize weeks;
@synthesize days;
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
                     clockTickerViewWeek1,
                     clockTickerViewWeek2,
                     clockTickerViewDay1,
                     clockTickerViewDay2,
                     clockTickerViewHour1,
                     clockTickerViewHour2,
                     clockTickerViewMinute1,
                     clockTickerViewMinute2,
                     clockTickerViewSecond1,
                     clockTickerViewSecond2, nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HHmmss"];
    
    //RX Set the start and end date
    self.startDate = @"2013-08-05 104315";
    self.endDate = @"2013-10-06 201020";
    
    //RX The Start Date
    NSDate *startingDate = [formatter dateFromString:self.startDate];
    //RX The End Date
    NSDate *endingDate = [formatter dateFromString:self.endDate];
    
    
    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //RX gets the calender units for the differences
    NSUInteger unitFlags =  NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *componentsDaysDiff = [calendar components:unitFlags
                                                       fromDate:startingDate
                                                         toDate:endingDate
                                                        options:0];
    
    self.weeks = [componentsDaysDiff week];
    self.days = [componentsDaysDiff day];
    self.hours = [componentsDaysDiff hour];
    self.minutes = [componentsDaysDiff minute];
    self.seconds = [componentsDaysDiff second];
    
    NSString *weekStr = [NSString stringWithFormat:@"%d", self.weeks];
    NSString *dayStr = [NSString stringWithFormat:@"%d", self.days];
    NSString *hourStr = [NSString stringWithFormat:@"%d", self.hours];
    NSString *minuteStr = [NSString stringWithFormat:@"%d", self.minutes];
    NSString *secondStr = [NSString stringWithFormat:@"%d", self.seconds];
    
    NSLog(@"hour %i",weekStr.length);
    NSLog(@"minute %i",dayStr.length);
    NSLog(@"hour %i",hourStr.length);
    NSLog(@"minute %i",minuteStr.length);
    NSLog(@"second %i",secondStr.length);
    
    for(int i = 0;i < _clockTickers.count;i++){
        switch (i) {
            case 0:
                if ([weekStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[weekStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                    NSLog(@"1");
                }
                break;
            case 1:
                if ([weekStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[weekStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                    NSLog(@"1");
                }
            case 2:
                if ([dayStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[dayStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                    NSLog(@"1");
                }
                break;
            case 3:
                if ([dayStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[dayStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                    NSLog(@"1");
                }

                break;
            case 4:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];  
                     NSLog(@"1");
                }
                break;
            case 5:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(1, 1)] fontSize:FONT_SIZE]];
                     NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:hourStr fontSize:FONT_SIZE]];  
                     NSLog(@"2");
                }
                break;
            case 6:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                     NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                     NSLog(@"1");
                }
                break;
            case 7:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(1, 1)] fontSize:FONT_SIZE]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:minuteStr fontSize:FONT_SIZE]];
                }

                break;
            case 8:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                }
                break;
            case 9:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(1, 1)] fontSize:FONT_SIZE]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:secondStr fontSize:FONT_SIZE]];
                }
                break;
                
            default:
                break;
        }
    }
    
    if([startingDate compare:endingDate] == NSOrderedDescending){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Wrong Date" message:@"The start date can't be after the end date?" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"cancel", nil];
        [alert show];
        
        for(int i = 0;i < _clockTickers.count;i++){
            [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
        }
        
        self.timer = FALSE;
    } else {
        self.timer = TRUE;
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
                self.hours = 24;
                if(self.days != 0){
                    self.days --;
                } else {
                    self.days = 7;
                    if(self.weeks != 0){
                        self.weeks --;
                    } else {
                        //** This is the end of the timer: Do something AND stop calling this function **//
                        
                        self.timer = FALSE;
                        
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Times up baby" message:@"Time!! Time!!" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"cancel", nil];
                        [alert show];
                    }
                }
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
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                    NSLog(@"1");
                }
                break;
            case 1:
                if ([hourStr length] == 2){
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[hourStr substringWithRange:NSMakeRange(1, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:hourStr fontSize:FONT_SIZE]];
                    NSLog(@"2");
                }
                break;
            case 2:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                    NSLog(@"2");
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                    NSLog(@"1");
                }
                break;
            case 3:
                if (minuteStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[minuteStr substringWithRange:NSMakeRange(1, 1)] fontSize:FONT_SIZE]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:minuteStr fontSize:FONT_SIZE]];
                }
                
                break;
            case 4:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(0, 1)] fontSize:FONT_SIZE]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:FONT_SIZE]];
                }
                break;
            case 5:
                if (secondStr.length == 2) {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:[secondStr substringWithRange:NSMakeRange(1, 1)] fontSize:FONT_SIZE]];
                } else {
                    [[_clockTickers objectAtIndex:i] setFrontView:[SBTickView tickViewWithTitle:secondStr fontSize:FONT_SIZE]];
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
            [obj setBackView:[SBTickView tickViewWithTitle:[newClock substringWithRange:NSMakeRange(idx, 1)] fontSize:FONT_SIZE]];
            NSLog(@"new clock: %@",[newClock substringWithRange:NSMakeRange(idx, 1)]);
            [obj tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
            NSLog(@"Ticking");
        }
    }];
    
    _currentClock = newClock;
}

@end
