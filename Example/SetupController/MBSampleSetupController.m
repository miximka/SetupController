//
//  MBSampleSetupController.m
//  SetupController
//
//  Created by Maksim Bauer on 26/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSampleSetupController.h"
#import "MBAccountController.h"
#import "MBProgressController.h"
#import "MBWelcomeController.h"
#import "MBBackupController.h"
#import "MBProgressController.h"

@interface MBSampleSetupController()
@property (nonatomic) MBAccountController *accountController;
@end

@implementation MBSampleSetupController

- (MBWelcomeController *)finishController
{
    MBWelcomeController *controller = [[MBWelcomeController alloc] init];
    return controller;
}

- (IBAction)getStarted:(id)sender
{
    [self pushNext];
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBAccountController *initialController = [[MBAccountController alloc] init];
    [self setViewControllers:@[initialController] animated:NO];
}

#pragma mark - MBSetupControllerDataSource

- (UIViewController<MBPage> *)setupController:(MBSetupController *)setupController viewControllerAfterViewController:(UIViewController<MBPage> *)viewController
{
    if ([viewController isKindOfClass:[MBAccountController class]]) {
        MBProgressController *progressController = [[MBProgressController alloc] init];
        progressController.labelTitle = @"It may take a while to set up your account...";
        progressController.tag = 0;
        return progressController;
    }

    if ([viewController isKindOfClass:[MBBackupController class]]) {
        if (viewController.isSkipped) {
            return [self finishController];
        } else {
            MBProgressController *progressController = [[MBProgressController alloc] init];
            progressController.labelTitle = @"It may take a while to restore a backup...";
            progressController.tag = 1;
            return progressController;
        }
    }

    if ([viewController isKindOfClass:[MBProgressController class]]) {
        MBProgressController *progressController = (MBProgressController *)viewController;
        if (progressController.tag == 0) {
            return [[MBBackupController alloc] init];
        }
        
        return [self finishController];
    }
    
    return nil;
}

@end
