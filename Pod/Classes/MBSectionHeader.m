//
//  MBSectionHeader.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSectionHeader.h"
#import "MBSetupControllerUtilities.h"

@interface MBSectionHeader()
@property (nonatomic) NSLayoutConstraint *labelTopMarginConstraint;
@property (nonatomic) NSLayoutConstraint *labelBottomMarginConstraint;
@end

@implementation MBSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    _titleLabelInset = UIEdgeInsetsMake(0.0, 0, 10.0, 0);

    UILabel *label = [MBSetupControllerUtilities captionStyledLabel];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    
    _labelTopMarginConstraint = [NSLayoutConstraint constraintWithItem:label
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:_titleLabelInset.top];
    [self addConstraint:_labelTopMarginConstraint];

    _labelBottomMarginConstraint = [NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                   toItem:label
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.0
                                                                 constant:_titleLabelInset.bottom];
    [self addConstraint:_labelBottomMarginConstraint];

    _titleLabel = label;
}

- (void)setTitleLabelInset:(UIEdgeInsets)inset
{
    _titleLabelInset = inset;
    _labelTopMarginConstraint.constant = inset.top;
    _labelBottomMarginConstraint.constant = inset.bottom;
}

#pragma mark - Overridden Methods

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize fittingSize = [self.titleLabel sizeThatFits:size];
    fittingSize.height += _titleLabelInset.top + _titleLabelInset.bottom;
    
    return fittingSize;
}

@end
