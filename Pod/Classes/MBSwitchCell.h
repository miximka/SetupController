//
//  MBSwitchCell.h
//  SetupController
//

#import "MBSetupPageCell.h"
#import "MBSwitchItem.h"

@interface MBSwitchCell : MBSetupPageCell

@property (nonatomic, readonly, nullable) UILabel *titleLabel;
@property (nonatomic, readonly, nullable) UISwitch *switchView;

@property (nonatomic, nullable) MBSwitchItem *item;

@end
