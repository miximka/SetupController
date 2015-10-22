//
//  MBSetupPageCell.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageCell.h"
#import "MBSetupPageItem.h"
#import "MBSetupControllerUtilities.h"

@interface MBSetupPageCell ()
@property (nonatomic) UIView *separatorView;
@end

@implementation MBSetupPageCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _cellDidLoad];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _cellDidLoad];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _cellDidLoad];
    }
    return self;
}

- (void)dealloc
{
    // Set item to nil to unregister from all KVO notifications
    [self setItem:nil];
}

- (void)setCustomSeparatorStyle:(UITableViewCellSeparatorStyle)customSeparatorStyle {
    if (_customSeparatorStyle != customSeparatorStyle) {
        _customSeparatorStyle = customSeparatorStyle;
        [self updateSeparatorView];
    }
}

- (UIView *)addSeparatorView
{
    if (!self.backgroundView) {
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundView = view;
    }
    
    UIView *separatorSuperview = self.backgroundView;
    
    UIView *separatorView = [[UIView alloc] init];
    separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    separatorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [separatorSuperview addSubview:separatorView];
    
    [separatorSuperview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[separatorView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separatorView)]];
    [separatorSuperview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[separatorView(0.5)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(separatorView)]];
    
    return separatorView;
}

- (void)updateSeparatorView
{
    [_separatorView removeFromSuperview];
    if ([self customSeparatorStyle] != UITableViewCellSeparatorStyleNone) {
        _separatorView = [self addSeparatorView];
    }
}

- (void)_cellDidLoad
{
    [self updateSeparatorView];
    
    if ([MBSetupControllerUtilities isAutosizingTableViewCellsSupported]) {
        //Add minimal height constraint, to prevent that tableview complains about possible zero height
        //if cell does not define enough constraints to compute cell's height
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView
                                                                     attribute:NSLayoutAttributeHeight
                                                                     relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                        toItem:nil
                                                                     attribute:0
                                                                    multiplier:1.0
                                                                      constant:44.0]];
    }
    
    [self cellDidLoad];
}

- (void)cellDidLoad
{
}

- (void)cellWillAppear
{
}

@end

@implementation MBSetupPageCell (Friend)

- (void)_cellWillAppear
{
    self.selectionStyle = self.item.selectionStyle;
    self.accessoryType = self.item.accessoryType;
    
    [self cellWillAppear];
}

@end