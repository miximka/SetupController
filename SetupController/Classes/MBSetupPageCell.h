//
//  MBSetupPageCell.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBSetupPageItem;

@interface MBSetupPageCell : UITableViewCell

@property (nonatomic, nullable) MBSetupPageItem *item;
@property (nonatomic) UITableViewCellSeparatorStyle customSeparatorStyle;

/**
    Called just after the cell is created.
 */
- (void)cellDidLoad;

/**
    Called when cell is about to be presented.
 */
- (void)cellWillAppear;

@end
