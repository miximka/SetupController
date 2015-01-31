//
//  MBProgressPageController.m
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBProgressPageController.h"

@interface MBProgressPageController ()
@end

@implementation MBProgressPageController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.hidesNextButton = YES;
        self.removeWhenDone = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesNextButton = YES;
        self.removeWhenDone = YES;
    }
    return self;
}

- (void)addContentViews
{
    UIView *contentView = self.contentView;
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:indicator];
    _activityIndicator = indicator;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(indicator, titleLabel);
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:indicator
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]];
    
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:views]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator]-[titleLabel]" options:0 metrics:nil views:views]];
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addContentViews];
}

@end
