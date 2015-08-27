//
//  MBFinishPageController.h
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBBasePageController.h"

@interface MBFinishPageController : MBBasePageController

@property (nonatomic, readonly, nullable) UIImageView *imageView;
@property (nonatomic, readonly, nullable) UILabel *titleLabel;
@property (nonatomic, readonly, nullable) UIButton *button;

@end
