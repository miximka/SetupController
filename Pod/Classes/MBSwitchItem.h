//
//  MBSwitchItem.h
//  SetupController
//

#import "MBSetupPageItem.h"

@interface MBSwitchItem : MBSetupPageItem

- (instancetype)initWithTitle:(NSString *)title value:(BOOL)value;

@property (nonatomic) BOOL value;

@end
