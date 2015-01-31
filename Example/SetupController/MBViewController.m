//
//  MBViewController.m
//  SetupController
//
// Created by Maksim Bauer on 26/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBViewController.h"
#import "MBSampleSetupController.h"

@interface MBViewController () <MBSetupControllerDelegate>

@end

@implementation MBViewController

- (IBAction)startSetup:(id)sender
{
    MBSampleSetupController *setupController = [[MBSampleSetupController alloc] init];
    setupController.dataSource = setupController;
    setupController.delegate = self;
    
    [self presentViewController:setupController animated:YES completion:nil];
}

#pragma mark - MBSetupControllerDelegate

- (void)setupControllerDidFinish:(MBSetupController *)setupController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
