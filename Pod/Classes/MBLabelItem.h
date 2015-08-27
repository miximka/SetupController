//
//  MBLabelItem.h
//  SetupController
//
//  Created by Maksim Bauer on 31/01/15.
//  Copyright (c) 2015 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBLabelItem : MBSetupPageItem

- (instancetype)initWithTitle:(nullable NSString *)title detail:(nullable NSString *)detail style:(UITableViewCellStyle)style;

@property (nonatomic, nullable) NSString *detail;
@property (nonatomic) UITableViewCellStyle style;

@end

NS_ASSUME_NONNULL_END