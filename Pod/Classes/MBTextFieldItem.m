//
//  MBTextFieldItem.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBTextFieldItem.h"
#import "MBTextFieldCell.h"

@implementation MBTextFieldItem

- (instancetype)initWithTitle:(NSString *)title text:(NSString *)text placeholder:(NSString *)placeholder
{
    self = [super initWithTitle:title];
    if (self) {
        //Make text field cell non-selectable
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _text = text;
        _placeholder = placeholder;
        _clearButtonMode = UITextFieldViewModeWhileEditing;
        _keyboardType = UIKeyboardTypeDefault;
        _autocorrectionType = UITextAutocorrectionTypeDefault;
        _autocapitalizationType = UITextAutocapitalizationTypeSentences;
        
        self.createCellBlock = ^MBSetupPageCell *(MBSetupPageItem *item) {
            MBTextFieldCell *cell = [[MBTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:item.cellIdentifier];
            return cell;
        };

        self.configureCellBlock = ^(MBSetupPageItem *item, MBSetupPageCell *cell) {
            cell.item = item;
        };
        
        self.cellHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageItem *item, MBSetupPageCell *cell) {
            cell.item = item;
            CGSize fittingSize = CGSizeMake(tableView.bounds.size.width, 0);
            CGSize size = [cell sizeThatFits:fittingSize];
            return size.height;
        };
    }
    return self;
}

- (NSString *)cellIdentifier
{
    return @"MBTextFieldCell";
}

@end
