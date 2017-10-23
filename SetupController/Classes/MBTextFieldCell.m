//
//  MBTextFieldCell.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBTextFieldCell.h"
#import "MBTextFieldItem.h"

static int MBTextFieldCellContext;

#define DEFAULT_MIN_TITLE_LABEL_WIDTH 110

@interface MBTextFieldCell() <UITextFieldDelegate>
@property (nonatomic) BOOL updatingItemText;
@end

@implementation MBTextFieldCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_textField];
}

#pragma mark - Overridden Methods

- (void)setItem:(MBTextFieldItem *)item
{
    if (self.item != item) {
        [self.item removeObserver:self forKeyPath:NSStringFromSelector(@selector(text)) context:&MBTextFieldCellContext];
        [super setItem:item];
        [self.item addObserver:self forKeyPath:NSStringFromSelector(@selector(text)) options:0 context:&MBTextFieldCellContext];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];

    UIView *contentView = self.contentView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [titleLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    [contentView addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:textField];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel, textField);
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]-[textField]-|" options:0 metrics:nil views:views]];
    [titleLabel addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                              toItem:nil
                                                           attribute:0
                                                          multiplier:1.0
                                                            constant:DEFAULT_MIN_TITLE_LABEL_WIDTH]];
    
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:titleLabel
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0.0]];

    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:textField
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0.0]];
    
    _titleLabel = titleLabel;
    _textField = textField;
    
    textField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    MBTextFieldItem *item = (MBTextFieldItem *)self.item;

    self.titleLabel.text = item.title;
    self.textField.clearButtonMode = item.clearButtonMode;
    self.textField.keyboardType = item.keyboardType;
    self.textField.autocorrectionType = item.autocorrectionType;
    self.textField.autocapitalizationType = item.autocapitalizationType;
    self.textField.secureTextEntry = item.secureTextEntry;
    self.textField.text = item.text;
    self.textField.placeholder = item.placeholder;
}

#pragma mark - Overridden Methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        //Automatically start editing
        [self.textField becomeFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    MBTextFieldItem *item = (MBTextFieldItem *)self.item;
    if (item.textDidEndEditingBlock) {
        item.textDidEndEditingBlock(item);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Notifications

- (void)textDidChange:(NSNotification *)notification
{
    MBTextFieldItem *item = (MBTextFieldItem *)self.item;
    
    _updatingItemText = YES;
    item.text = self.textField.text;
    _updatingItemText = NO;
    
    if (item.textDidChangeBlock) {
        item.textDidChangeBlock(item);
    }
}

#pragma mark - KVO Notifications

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &MBTextFieldCellContext) {
        MBTextFieldItem *item = (MBTextFieldItem *)self.item;
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(text))]) {
            //Items text did change
            if (!_updatingItemText) {
                self.textField.text = item.text;
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
