//
//  MBBackupController.m
//  SetupController
//
//  Created by Maksim Bauer on 31/01/15.
//  Copyright (c) 2015 Maksim Bauer. All rights reserved.
//

#import "MBBackupController.h"
#import "MBSetupPageSection.h"
#import "MBSectionHeader.h"
#import "MBSectionFooter.h"
#import "MBLabelItem.h"

@interface MBLabel : UILabel
@property (nonatomic) UIEdgeInsets insets;
@end

@implementation MBLabel
- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}
@end

@interface MBBackupController ()
@end

@implementation MBBackupController

- (void)backupWithItem:(MBSetupPageItem *)item
{
    [self proceedToNextPage];
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hidesNextButton = YES;
    
    __weak MBBackupController *weakSelf = self;
    
    //Header section
    MBSetupPageSection *headerSection = [MBSetupPageSection sectionWithTitle:@"Restore Backup"];
    headerSection.headerViewBlock = ^UIView*(MBSetupPageSection *section) {
        return [weakSelf preparedPageHeaderViewWithTitle:section.title];
    };
    
    headerSection.headerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        CGSize size = [view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
        return size.height;
    };
    
    //Backup section
    MBSetupPageSection *backupSection = [MBSetupPageSection sectionWithTitle:@"All Backups"];
    
    backupSection.headerViewBlock = ^UIView *(MBSetupPageSection *section) {
        MBLabel *label = [[MBLabel alloc] init];
        label.insets = UIEdgeInsetsMake(0, 10.0, 0, 0);
        label.text = [section.title uppercaseString];
        return label;
    };

    backupSection.headerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        return 44.0;
    };

    backupSection.footerViewBlock = ^UIView *(MBSetupPageSection *section) {
        MBSectionFooter *footer = [weakSelf preparedFooterViewWithImage:nil
                                                                  title:nil
                                                               subtitle:nil];
        [footer.topButton setTitle:@"Skip This Step" forState:UIControlStateNormal];
        [footer.topButton addTarget:weakSelf action:@selector(skip) forControlEvents:UIControlEventTouchUpInside];
        return footer;
    };
    
    backupSection.footerHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageSection *section, UIView *view) {
        CGSize size = [view sizeThatFits:CGSizeMake(tableView.frame.size.width, 0)];
        return size.height;
    };
    
    MBLabelItem *backupItem1 = [[MBLabelItem alloc] initWithTitle:@"12 June 2015 23:39 pm" detail:@"My iPad 2" style:UITableViewCellStyleSubtitle];
    backupItem1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    backupItem1.didSelectBlock = ^(MBSetupPageItem *item) {
        [weakSelf backupWithItem:item];
        [item deselectAnimated:YES];
    };

    MBLabelItem *backupItem2 = [[MBLabelItem alloc] initWithTitle:@"22 June 2015 16:01 pm" detail:@"My iPad 2" style:UITableViewCellStyleSubtitle];
    backupItem2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    backupItem2.didSelectBlock = ^(MBSetupPageItem *item) {
        [weakSelf backupWithItem:item];
        [item deselectAnimated:YES];
    };

    backupSection.items = @[backupItem1, backupItem2];
    self.sections = @[headerSection, backupSection];
    
    // Use table view separators
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (UITableViewCellSeparatorStyle)customCellSeparatorStyle {
    // Disable custom separators
    return UITableViewCellSeparatorStyleNone;
}

- (BOOL)validate
{
    BOOL success = [super validate];
    self.nextButtonItem.enabled = success;
    
    return success;
}

@end
