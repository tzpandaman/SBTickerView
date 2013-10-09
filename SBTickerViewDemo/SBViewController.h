//
//  SBViewController.h
//  SBTickerViewDemo
//
//  Created by Simon Blommegård on 2011-12-10.
//  Copyright (c) 2011 Simon Blommegård. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBTickerView;

@interface SBViewController : UIViewController {
    NSString *_currentClock;
    NSArray *_clockTickers;
}
@property (nonatomic, strong) IBOutlet SBTickerView *fullTickerView;
@property (nonatomic, strong) IBOutlet SBTickerView *imageTickerView;
@property (nonatomic, strong) IBOutlet SBTickerView *clockTickerViewHour1;
@property (nonatomic, strong) IBOutlet SBTickerView *clockTickerViewHour2;
@property (nonatomic, strong) IBOutlet SBTickerView *clockTickerViewMinute1;
@property (nonatomic, strong) IBOutlet SBTickerView *clockTickerViewMinute2;
@property (nonatomic, strong) IBOutlet SBTickerView *clockTickerViewSecond1;
@property (nonatomic, strong) IBOutlet SBTickerView *clockTickerViewSecond2;

@property (strong, nonatomic) IBOutlet SBTickerView *clockTickerViewDay2;
@property (strong, nonatomic) IBOutlet SBTickerView *clockTickerViewDay1;
@property (strong, nonatomic) IBOutlet SBTickerView *clockTickerViewWeek2;
@property (strong, nonatomic) IBOutlet SBTickerView *clockTickerViewWeek1;

@property (nonatomic, strong) IBOutlet UIView *frontView;
@property (nonatomic, strong) IBOutlet UIView *backView;

@property (nonatomic, weak) NSString *startDate;

@property (nonatomic, weak) NSString *endDate;

@property (nonatomic) NSInteger weeks;
@property (nonatomic) NSInteger days;
@property (nonatomic) NSInteger hours;
@property (nonatomic) NSInteger minutes;
@property (nonatomic) NSInteger seconds;

@property (nonatomic) BOOL timer;

- (IBAction)tick:(id)sender;
@end
