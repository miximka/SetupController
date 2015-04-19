//
//  MBSwitchCell.m
//  SetupController
//

#import "MBSwitchCell.h"
#import "MBSwitchItem.h"

static int MBSwitchCellContext;

#define DEFAULT_MIN_TITLE_LABEL_WIDTH 110

@interface MBSwitchCell() <UITextFieldDelegate>
@property (nonatomic) BOOL updatingItemText;
@property (nonatomic) NSArray *horizontalSwitchConstraints;
@end

@implementation MBSwitchCell

@dynamic item;

- (void)dealloc
{
    [_switchView removeTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchDidChange: (id) sender
{
    MBSwitchItem *item = (MBSwitchItem *)self.item;
    item.value = _switchView.on;
}

- (void)updateSwitchViewConstraints
{
    if (_horizontalSwitchConstraints) {
        [self.contentView removeConstraints:_horizontalSwitchConstraints];
        [self setNeedsUpdateConstraints];
    }
}

#pragma mark - Overridden Methods

- (void)setItem:(MBSwitchItem *)item
{
    if (self.item != item) {
        
        [self.item removeObserver:self forKeyPath:NSStringFromSelector(@selector(value)) context:&MBSwitchCellContext];
        [self.item removeObserver:self forKeyPath:NSStringFromSelector(@selector(switchAlignment)) context:&MBSwitchCellContext];
        
        [super setItem:item];

        [self.item addObserver:self forKeyPath:NSStringFromSelector(@selector(value)) options:0 context:&MBSwitchCellContext];
        [self.item addObserver:self forKeyPath:NSStringFromSelector(@selector(switchAlignment)) options:0 context:&MBSwitchCellContext];
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
    
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:switchView];

    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel);
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLabel]" options:0 metrics:nil views:views]];
    
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
                                                               toItem:switchView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0
                                                             constant:0.0]];
    
    _titleLabel = titleLabel;
    _switchView = switchView;

    [switchView addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    MBSwitchItem *item = (MBSwitchItem *)self.item;

    self.titleLabel.text = item.title;
    self.switchView.on = item.value;
    
    // Switch alignment may have been changed so we have to update constraints
    [self updateSwitchViewConstraints];
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    NSMutableArray *hSwitchConstraints = [NSMutableArray new];
    
    UILabel *titleLabel = self.titleLabel;
    UISwitch *switchView = self.switchView;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel, switchView);
    
    if (self.item.switchAlignment == MBSwitchAlignmentLeft) {
        [hSwitchConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[titleLabel]-[switchView]" options:0 metrics:nil views:views]];
    } else {
        [hSwitchConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"[titleLabel]-(>=8)-[switchView]-|" options:0 metrics:nil views:views]];
    }
    
    [self.contentView addConstraints:hSwitchConstraints];
    _horizontalSwitchConstraints = hSwitchConstraints;
}

#pragma mark - KVO Notifications

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == &MBSwitchCellContext) {
        MBSwitchItem *item = (MBSwitchItem *)self.item;
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(value))]) {
            //Items text did change
            if (!_updatingItemText) {
                self.switchView.on = item.value;
            }
        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(switchAlignment))]) {
            [self updateSwitchViewConstraints];
            [self setNeedsUpdateConstraints];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
