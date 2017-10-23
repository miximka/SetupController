//
//  MBSectionHeader.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBSectionHeader : UIView

@property (nonatomic, readonly, nullable) UILabel *titleLabel;

/**
    Title label's top and bottom insets
 */
@property (nonatomic) UIEdgeInsets titleLabelInset;

@end
