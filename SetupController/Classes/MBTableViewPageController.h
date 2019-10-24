//
//  MBSetupPageController.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBBasePageController.h"

NS_ASSUME_NONNULL_BEGIN

@class MBSectionHeader;
@class MBSectionFooter;
@class MBSetupPageSection;

@interface MBTableViewPageController : MBBasePageController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly, nullable) UITableView *tableView;

#pragma mark - Customizing Appearance

@property (nonatomic) BOOL useAutosizingCells;

/**
    Apple does not allow per-cell separator customization, so we have to do it manually.
    One then completely disables the standard UITableView separators and returns something
    different than UITableViewCellSeparatorStyleNone for this property to add custom separator view in the cells.
 */
@property (nonatomic, readonly) UITableViewCellSeparatorStyle customCellSeparatorStyle;

- (UIEdgeInsets)tableViewContentInsetByAccountingForKeyboardFrame:(CGRect)keyboardFrame;

#pragma mark - Providing Table View Content

@property (nonatomic) NSArray<MBSetupPageSection *> *sections;

/**
    Convenient method to create page header view with specified title.
 */
- (MBSectionHeader *)preparedPageHeaderViewWithTitle:(nullable NSString *)title;
- (MBSectionFooter *)preparedFooterViewWithImage:(nullable UIImage *)image title:(nullable NSString *)title subtitle:(nullable NSString *)subtitle;

#pragma mark - Uer Input Validation

- (BOOL)validate;

@end

NS_ASSUME_NONNULL_END
