//
//  MBSetupPageSection.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MBTableViewPageController;
@class MBSetupPageSection;
@class MBSetupPageItem;

typedef CGFloat(^MBSetupPageSectionViewHeightBlock)(UITableView *tableView, MBSetupPageSection *section, UIView *view);

@interface MBSetupPageSection : NSObject

- (instancetype)initWithTitle:(nullable NSString *)title;
+ (instancetype)sectionWithTitle:(nullable NSString *)title;

/**
    Receiver's title.
 */
@property (nonatomic, nullable) NSString *title;

/**
    Block to return header view for the receiver.
 */
@property (copy, nonatomic, nullable) UIView *(^headerViewBlock)(MBSetupPageSection *section);

/**
    Block to return header view height.
 */
@property (copy, nonatomic, nullable) MBSetupPageSectionViewHeightBlock headerHeightBlock;

/**
    Block to return footer view for the receiver.
 */
@property (copy, nonatomic, nullable) UIView *(^footerViewBlock)(MBSetupPageSection *section);

/**
    Block to return footer view height.
 */
@property (copy, nonatomic, nullable) MBSetupPageSectionViewHeightBlock footerHeightBlock;

#pragma mark - Parent Controller

@property (weak, nonatomic, readonly, nullable) MBTableViewPageController *parentController;

#pragma mark - Providing Section Items

/**
    Section row items.
 */
@property (nonatomic) NSArray<MBSetupPageItem *> *items;

- (void)insertItem:(MBSetupPageItem *)item atIndex:(NSInteger)index;

#pragma mark - Validation

/**
    Validate items.
 */
- (BOOL)validate;

#pragma mark - Handling Selection

- (void)deselectItem:(MBSetupPageItem *)item animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
