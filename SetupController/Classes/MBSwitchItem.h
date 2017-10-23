//
//  MBSwitchItem.h
//  SetupController
//

#import "MBSetupPageItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MBSwitchAlignment) {
    MBSwitchAlignmentLeft = 0,
    MBSwitchAlignmentRight
};

@interface MBSwitchItem : MBSetupPageItem

- (instancetype)initWithTitle:(nullable NSString *)title value:(BOOL)value;

@property (nonatomic) BOOL value;
@property (nonatomic) MBSwitchAlignment switchAlignment; // MBSwitchAlignmentRight is the default value.

@end

NS_ASSUME_NONNULL_END