//
//  MBFinishPageController.m
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBFinishPageController.h"
#import "MBSetupControllerUtilities.h"

@interface MBFinishPageController ()
@end

@implementation MBFinishPageController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.hidesNextButton = YES;
        self.hidesBackButton = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesNextButton = YES;
        self.hidesBackButton = YES;
    }
    return self;
}

- (void)addContentViews
{
    UIView *contentView = self.contentView;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:imageView];
    _imageView = imageView;
    
    UILabel *titleLabel = [MBSetupControllerUtilities captionStyledLabel];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:21];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:button];
    _button = button;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(imageView, titleLabel, button);

    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:imageView
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]];

    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:views]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:-20.0]];

    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                            attribute:NSLayoutAttributeCenterX
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeCenterX
                                                           multiplier:1.0
                                                             constant:0]];

    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView]-[titleLabel]-[button]" options:0 metrics:nil views:views]];
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addContentViews];
}

@end
