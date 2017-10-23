//
//  MBWelcomeController.m
//  SetupController
//
//  Created by mab on 23/02/15.
//  Copyright (c) 2015 Maksim Bauer. All rights reserved.
//

#import "MBWelcomeController.h"

@interface MBWelcomeController ()

@end

@implementation MBWelcomeController

- (IBAction)getStarted:(id)sender
{
    [self proceedToNextPage];
}

#pragma - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:@"SampleImage"];
    self.titleLabel.text = [NSString stringWithFormat:@"Welcome to SetupController"];
    
    [self.button setTitle:@"Get Started" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(getStarted:) forControlEvents:UIControlEventTouchUpInside];
}

@end
