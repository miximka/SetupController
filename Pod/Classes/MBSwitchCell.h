//
//  MBSwitchCell.h
//  SetupController
//

#import "MBSetupPageCell.h"
#import "MBSwitchItem.h"

@interface MBSwitchCell : MBSetupPageCell

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UISwitch *switchView;

@property (nonatomic) MBSwitchItem *item;

@end
