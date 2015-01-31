//
//  MBSetupPageController.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBBasePageController.h"

@class MBSectionHeader;
@class MBSectionFooter;

@interface MBTableViewPageController : MBBasePageController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) UITableView *tableView;

#pragma mark - Customizing Appearance

@property (nonatomic) BOOL useAutosizingCells;

#pragma mark - Providing Table View Content

@property (nonatomic) NSArray *sections;
- (void)setSections:(NSArray *)sections;

/**
    Convenient method to create page header view with specified title.
 */
- (MBSectionHeader *)preparedPageHeaderViewWithTitle:(NSString *)title;
- (MBSectionFooter *)preparedFooterViewWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle;

#pragma mark - Uer Input Validation

- (BOOL)validate;

@end
