//
//  MBAccountController.m
//  SetupController
//
//  Created by Maksim Bauer on 28/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBAccountController.h"
#import "MBSetupPageSection.h"
#import "MBSectionHeader.h"
#import "MBSectionFooter.h"
#import "MBTextFieldItem.h"
#import "MBSwitchItem.h"

@implementation MBAccountController

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak MBAccountController *weakSelf = self;
    
    //Configure section
    MBSetupPageSection *section = [MBSetupPageSection sectionWithTitle:@"Configure Account"];
    section.headerViewBlock = ^UIView*(MBSetupPageSection *section) {
        return [weakSelf preparedPageHeaderViewWithTitle:section.title];
    };
    
    section.headerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        CGSize size = [view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
        return size.height;
    };

    section.footerViewBlock = ^UIView*(MBSetupPageSection *section) {
        MBSectionFooter *footer = [weakSelf preparedFooterViewWithImage:[UIImage imageNamed:@"SampleImage"]
                                                                  title:@"Sign in with your account credentials"
                                                               subtitle:@"Your credentials should have been sent to you by administrator. Contact our support team if you have any questions."];
        [footer.topButton setTitle:@"Skip This Step" forState:UIControlStateNormal];
        [footer.topButton addTarget:weakSelf action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    };
    section.footerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        CGSize size = [view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
        return size.height;
    };
    
    MBTextFieldItem *hostItem = [[MBTextFieldItem alloc] initWithTitle:@"Host" text:nil placeholder:@"example.com"];
    hostItem.keyboardType = UIKeyboardTypeURL;
    hostItem.autocorrectionType = UITextAutocorrectionTypeNo;
    hostItem.autocapitalizationType = UITextAutocapitalizationTypeNone;
    hostItem.textDidChangeBlock = ^(MBTextFieldItem *item) {
        [weakSelf validate];
    };
    hostItem.validateBlock = ^BOOL(MBSetupPageItem *item) {
        return [(MBTextFieldItem *)item text].length > 0;
    };
    
    MBTextFieldItem *loginItem = [[MBTextFieldItem alloc] initWithTitle:@"Login" text:nil placeholder:@"email@example.com"];
    loginItem.keyboardType = UIKeyboardTypeEmailAddress;
    loginItem.autocorrectionType = UITextAutocorrectionTypeNo;
    loginItem.autocapitalizationType = UITextAutocapitalizationTypeNone;
    loginItem.textDidChangeBlock = ^(MBTextFieldItem *item) {
        [weakSelf validate];
    };
    loginItem.validateBlock = ^BOOL(MBSetupPageItem *item) {
        return [(MBTextFieldItem *)item text].length > 0;
    };
    
    MBTextFieldItem *passwordItem = [[MBTextFieldItem alloc] initWithTitle:@"Password" text:nil placeholder:@"Required"];
    passwordItem.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordItem.autocapitalizationType = UITextAutocapitalizationTypeNone;
    passwordItem.secureTextEntry = YES;
    passwordItem.textDidChangeBlock = ^(MBTextFieldItem *item) {
        [weakSelf validate];
    };
    passwordItem.validateBlock = ^BOOL(MBSetupPageItem *item) {
        return [(MBTextFieldItem *)item text].length > 0;
    };

    MBSwitchItem *connectionTypeItem = [[MBSwitchItem alloc] initWithTitle:@"Use SSL" value:YES];
    connectionTypeItem.switchAlignment = MBSwitchAlignmentLeft;
    
    section.items = @[hostItem, loginItem, passwordItem, connectionTypeItem];
    self.sections = @[section];
}

- (BOOL)validate
{
    BOOL success = [super validate];
    self.nextButtonItem.enabled = success;
    
    return success;
}

@end
