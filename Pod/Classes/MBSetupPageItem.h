//
//  MBSetupPageItem.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBSetupPageItem;
@class MBSetupPageCell;
@class MBSetupPageSection;

typedef CGFloat(^MBSetupPageItemCellHeightBlock)(UITableView *tableView, MBSetupPageItem *item, MBSetupPageCell *cell);

@interface MBSetupPageItem : NSObject

- (instancetype)initWithTitle:(NSString *)title;

@property (nonatomic) NSString *title;

/**
    Cell identifier.
 */
@property (nonatomic) NSString *cellIdentifier;

/**
    Parent section
 */
@property (weak, nonatomic, readonly) MBSetupPageSection *section;

#pragma mark - Configure Cell Appearance

@property (nonatomic) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic) UITableViewCellAccessoryType accessoryType;

/**
    Block to create table view cell.
 */
@property (copy, nonatomic) MBSetupPageCell *(^createCellBlock)(MBSetupPageItem *item);

/**
    Block to configure table view cell.
 */
@property (copy, nonatomic) void(^configureCellBlock)(MBSetupPageItem *item, MBSetupPageCell *cell);

/**
    Block to return height of the cell.
 */
@property (copy, nonatomic) MBSetupPageItemCellHeightBlock cellHeightBlock;

/**
    Item validation block
 */
@property (copy, nonatomic) BOOL(^validateBlock)(MBSetupPageItem *item);

#pragma mark - Handling Selection

/**
    Block called on the item's row selection.
 */
@property (copy, nonatomic) void(^didSelectBlock)(MBSetupPageItem *item);

- (void)deselectAnimated:(BOOL)animated;

@end
