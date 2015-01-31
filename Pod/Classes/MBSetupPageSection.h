//
//  MBSetupPageSection.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBTableViewPageController;
@class MBSetupPageSection;
@class MBSetupPageItem;

typedef CGFloat(^MBSetupPageSectionViewHeightBlock)(UITableView *tableView, MBSetupPageSection *section, UIView *view);

@interface MBSetupPageSection : NSObject

- (instancetype)initWithTitle:(NSString *)title;
+ (instancetype)sectionWithTitle:(NSString *)title;

/**
    Receiver's title.
 */
@property (nonatomic) NSString *title;

/**
    Block to return header view for the receiver.
 */
@property (copy, nonatomic) UIView *(^headerViewBlock)(MBSetupPageSection *section);

/**
    Block to return header view height.
 */
@property (copy, nonatomic) MBSetupPageSectionViewHeightBlock headerHeightBlock;

/**
    Block to return footer view for the receiver.
 */
@property (copy, nonatomic) UIView *(^footerViewBlock)(MBSetupPageSection *section);

/**
    Block to return footer view height.
 */
@property (copy, nonatomic) MBSetupPageSectionViewHeightBlock footerHeightBlock;

#pragma mark - Parent Controller

@property (weak, nonatomic, readonly) MBTableViewPageController *parentController;

#pragma mark - Providing Section Items

/**
    Section row items.
 */
@property (nonatomic) NSArray *items;

#pragma mark - Validation

/**
    Validate items.
 */
- (BOOL)validate;

#pragma mark - Handling Selection

- (void)deselectItem:(MBSetupPageItem *)item animated:(BOOL)animated;

@end
