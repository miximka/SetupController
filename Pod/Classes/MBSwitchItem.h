//
//  MBSwitchItem.h
//  SetupController
//

#import "MBSetupPageItem.h"

typedef NS_ENUM(NSInteger, MBSwitchAlignment) {
    MBSwitchAlignmentLeft = 0,
    MBSwitchAlignmentRight
};

@interface MBSwitchItem : MBSetupPageItem

- (instancetype)initWithTitle:(NSString *)title value:(BOOL)value;

@property (nonatomic) BOOL value;
@property (nonatomic) MBSwitchAlignment switchAlignment; // MBSwitchAlignmentRight is the default value.

@end
