//
//  MBLabelItem.m
//  SetupController
//
//  Created by Maksim Bauer on 31/01/15.
//  Copyright (c) 2015 Maksim Bauer. All rights reserved.
//

#import "MBLabelItem.h"
#import "MBLabelCell.h"

@implementation MBLabelItem

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail style:(UITableViewCellStyle)style
{
    self = [super initWithTitle:title];
    if (self) {
        _detail = detail;
        _style = style;
        
        self.createCellBlock = ^MBSetupPageCell *(MBSetupPageItem *item) {
            MBLabelItem *labelItem = (MBLabelItem *)item;
            MBLabelCell *cell = [[MBLabelCell alloc] initWithStyle:labelItem.style reuseIdentifier:labelItem.cellIdentifier];
            return cell;
        };
        
        self.configureCellBlock = ^(MBSetupPageItem *item, MBSetupPageCell *cell) {
            cell.item = item;
        };
        
        self.cellHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageItem *item, MBSetupPageCell *cell) {
            cell.item = item;
            CGSize fittingSize = CGSizeMake(tableView.bounds.size.width, 0);
            CGSize size = [cell sizeThatFits:fittingSize];
            return size.height;
        };

    }
    return self;
}

- (NSString *)cellIdentifier
{
    return @"MBLabelItem";
}

@end
