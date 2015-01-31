//
//  MBSectionFooter.m
//  SetupController
//
//  Created by Maksim Bauer on 28/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSectionFooter.h"

@interface MBSectionFooter ()
@property (nonatomic) NSArray *customConstraints;
@end

static int MBSectionFooterContext;

@implementation MBSectionFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configure];
    }
    return self;
}

- (void)dealloc
{
    [_topButton removeObserver:self forKeyPath:@"hidden" context:&MBSectionFooterContext];
    [_imageView removeObserver:self forKeyPath:@"hidden" context:&MBSectionFooterContext];
    [_titleLabel removeObserver:self forKeyPath:@"hidden" context:&MBSectionFooterContext];
    [_subtitleLabel removeObserver:self forKeyPath:@"hidden" context:&MBSectionFooterContext];
}

- (void)configure
{
    self.clipsToBounds = YES;
    
    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeSystem];
    topButton.translatesAutoresizingMaskIntoConstraints = NO;
    _topButton = topButton;
    [topButton addObserver:self forKeyPath:@"hidden" options:0 context:&MBSectionFooterContext];
    [self addSubview:topButton];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView addObserver:self forKeyPath:@"hidden" options:0 context:&MBSectionFooterContext];
    _imageView = imageView;
    [self addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [titleLabel addObserver:self forKeyPath:@"hidden" options:0 context:&MBSectionFooterContext];
    _titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    subtitleLabel.numberOfLines = 0;
    [subtitleLabel addObserver:self forKeyPath:@"hidden" options:0 context:&MBSectionFooterContext];
    _subtitleLabel = subtitleLabel;
    [self addSubview:subtitleLabel];
}

- (UIEdgeInsets)_layoutMargins
{
    UIEdgeInsets margins = UIEdgeInsetsMake(15.0, 8.0, 8.0, 8.0);
    return margins;
}

#pragma mark - Overridden Methods

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_topButton, _imageView, _titleLabel, _subtitleLabel);
    
    NSMutableArray *constraints = [NSMutableArray new];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_topButton
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0]];
    
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_imageView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0]];
    
    UIEdgeInsets margins = self._layoutMargins;
    
    NSMutableArray *components = [NSMutableArray new];
    
    if (!self.topButton.hidden) {
        [components addObject:@"[_topButton]"];
    }

    if (!self.imageView.hidden) {
        [components addObject:@"[_imageView]"];
    }

    if (!self.titleLabel.hidden) {
        [components addObject:@"[_titleLabel]"];
    }

    if (!self.subtitleLabel.hidden) {
        [components addObject:@"[_subtitleLabel]"];
    }

    if (components.count > 0) {
        
        NSString *marginStr = [NSString stringWithFormat:@"-%i-", (int)margins.bottom];
        NSString *joinedComponents = [components componentsJoinedByString:marginStr];
        
        NSString *constraintsFormat = [NSMutableString stringWithFormat:@"V:|-%f-%@", margins.top, joinedComponents];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:constraintsFormat options:0 metrics:nil views:views]];
    }
    
    NSString *format = [NSString stringWithFormat:@"H:|-%f-[_titleLabel]-%f-|", margins.left, margins.right];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views]];
    
    format = [NSString stringWithFormat:@"H:|-%f-[_subtitleLabel]-%f-|", margins.left, margins.right];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views]];
    
    _customConstraints = constraints;
    [self addConstraints:constraints];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    UIEdgeInsets margins = self._layoutMargins;

    CGFloat height = margins.top;
    
    if (!self.topButton.hidden) {
        CGFloat topButtonHeight = [self.topButton sizeThatFits:size].height;
        height += topButtonHeight + margins.bottom;
    }
    
    if (!self.imageView.hidden) {
        CGFloat imageViewHeight = [self.imageView sizeThatFits:size].height;
        height += imageViewHeight + margins.bottom;
    }

    CGSize sizeForLabels = size;
    sizeForLabels.width = size.width - (margins.left + margins.right);

    if (!self.titleLabel.hidden) {
        CGFloat titleLabelHeight = [self.titleLabel sizeThatFits:sizeForLabels].height;
        height += titleLabelHeight + margins.bottom;
    }
    
    if (!self.subtitleLabel.hidden) {
        CGFloat subtitleLabelHeight = [self.subtitleLabel sizeThatFits:sizeForLabels].height;
        height += subtitleLabelHeight;
    }

    return CGSizeMake(size.width, height);
}

#pragma mark - KVO Notifications

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &MBSectionFooterContext) {
        if ([keyPath isEqualToString:@"hidden"]) {
            if (_customConstraints) {
                [self removeConstraints:_customConstraints];
            }
            [self setNeedsUpdateConstraints];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
