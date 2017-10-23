//
//  MBLabelCell.m
//  SetupController
//
//  Created by Maksim Bauer on 31/01/15.
//  Copyright (c) 2015 Maksim Bauer. All rights reserved.
//

#import "MBLabelCell.h"
#import "MBLabelItem.h"

@implementation MBLabelCell

#pragma mark - Overridden Methods

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    MBLabelItem *item = (MBLabelItem *)self.item;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.detail;
}

@end
