//
//  MBTextFieldItem.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageItem.h"

@interface MBTextFieldItem : MBSetupPageItem

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text placeholder:(NSString *)placeholder;

@property (nonatomic) NSString *text;
@property (nonatomic) NSString *placeholder;

#pragma mark - Customize Text Field Appearance

@property (nonatomic) UITextFieldViewMode clearButtonMode;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UITextAutocorrectionType autocorrectionType;
@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

#pragma mark - Observe Text Field Changes

@property (nonatomic, copy) void(^textDidChangeBlock)(MBTextFieldItem *item);
@property (nonatomic, copy) void(^textDidEndEditingBlock)(MBTextFieldItem *item);

@end
