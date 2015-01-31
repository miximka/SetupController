//
//  MBTextFieldCell.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageCell.h"

@interface MBTextFieldCell : MBSetupPageCell

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UITextField *textField;

@end
