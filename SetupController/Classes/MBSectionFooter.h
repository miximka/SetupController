//
//  MBSectionFooter.h
//  SetupController
//
//  Created by Maksim Bauer on 28/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBSectionFooter : UIView

@property (nonatomic, readonly, nullable) UIButton *topButton;
@property (nonatomic, readonly, nullable) UIImageView *imageView;
@property (nonatomic, readonly, nullable) UILabel *titleLabel;
@property (nonatomic, readonly, nullable) UILabel *subtitleLabel;

@end
