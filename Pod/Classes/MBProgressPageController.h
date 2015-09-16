//
//  MBProgressPageController.h
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBBasePageController.h"

@interface MBProgressPageController : MBBasePageController

@property (nonatomic, readonly, nullable) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, readonly, nullable) UILabel *titleLabel;

@end
