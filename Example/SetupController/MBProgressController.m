//
//  MBSettingUpAccountController.m
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBProgressController.h"

@interface MBProgressController ()
@property (nonatomic) NSTimer *timer;
@end

@implementation MBProgressController

- (void)startActivity
{
    [self.activityIndicator startAnimating];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                              target:self
                                            selector:@selector(timerFired:)
                                            userInfo:nil
                                             repeats:NO];
}

- (void)cancelActivity
{
    [self.activityIndicator stopAnimating];
    
    [_timer invalidate];
    _timer = nil;
}

- (void)finishActivity
{
    [self.activityIndicator stopAnimating];
    [self proceedToNextPage];
}

#pragma mark - Overridden Methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleLabel.text = self.labelTitle;
    [self startActivity];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self cancelActivity];
}

#pragma mark - NSTimer callback

- (void)timerFired:(NSTimer *)timer
{
    _timer = nil;
    [self finishActivity];
}

@end
