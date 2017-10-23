//
//  MBSetupPageItem.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MBSetupPageItem;
@class MBSetupPageCell;
@class MBSetupPageSection;

typedef CGFloat(^MBSetupPageItemCellHeightBlock)(UITableView *tableView, MBSetupPageItem *item, MBSetupPageCell *cell);

@interface MBSetupPageItem : NSObject

- (instancetype)initWithTitle:(nullable NSString *)title;

@property (nonatomic, nullable) NSString *title;

/**
    Cell identifier.
 */
@property (nonatomic, nullable) NSString *cellIdentifier;

/**
    Parent section
 */
@property (weak, nonatomic, readonly, nullable) MBSetupPageSection *section;

#pragma mark - Configure Cell Appearance

@property (nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

/**
    Block to create table view cell.
 */
@property (copy, nonatomic, nullable) MBSetupPageCell *(^createCellBlock)(MBSetupPageItem *item);

/**
    Block to configure table view cell.
 */
@property (copy, nonatomic, nullable) void(^configureCellBlock)(MBSetupPageItem *item, MBSetupPageCell *cell);

/**
 *  Block called after configureCellBlock.
 */
@property (copy, nonatomic, nullable) void(^afterConfigureCellBlock)(MBSetupPageItem *item, MBSetupPageCell *cell);

/**
    Block to return height of the cell.
 */
@property (copy, nonatomic, nullable) MBSetupPageItemCellHeightBlock cellHeightBlock;

/**
    Item validation block
 */
@property (copy, nonatomic, nullable) BOOL(^validateBlock)(MBSetupPageItem *item);

#pragma mark - Handling Selection

/**
    Block called on the item's row selection.
 */
@property (copy, nonatomic, nullable) void(^didSelectBlock)(MBSetupPageItem *item);

- (void)deselectAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END