//
//  MBTextFieldItem.h
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBTextFieldItem : MBSetupPageItem

- (instancetype)initWithTitle:(nullable NSString *)title text:(nullable NSString *)text placeholder:(nullable NSString *)placeholder;

@property (nonatomic, nullable) NSString *text;
@property (nonatomic, nullable) NSString *placeholder;

#pragma mark - Customize Text Field Appearance

@property (nonatomic) UITextFieldViewMode clearButtonMode;
@property (nonatomic) UIKeyboardType keyboardType;
@property (nonatomic) UITextAutocorrectionType autocorrectionType;
@property (nonatomic) UITextAutocapitalizationType autocapitalizationType;
@property (nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

#pragma mark - Observe Text Field Changes

@property (nonatomic, copy, nullable) void(^textDidChangeBlock)(MBTextFieldItem *item);
@property (nonatomic, copy, nullable) void(^textDidEndEditingBlock)(MBTextFieldItem *item);

@end

NS_ASSUME_NONNULL_END