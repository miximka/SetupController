//
//  MBLabelItem.h
//  SetupController
//
//  Created by Maksim Bauer on 31/01/15.
//  Copyright (c) 2015 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageItem.h"

@interface MBLabelItem : MBSetupPageItem

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail style:(UITableViewCellStyle)style;

@property (nonatomic) NSString *detail;
@property (nonatomic) UITableViewCellStyle style;

@end
