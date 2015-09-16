//
//  MBSetupControllerUtilities.h
//  SetupController
//
//  Created by Maksim Bauer on 30/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MBSetupController;

@interface MBSetupControllerUtilities : NSObject
+ (nullable UILabel *)captionStyledLabel;
+ (BOOL)isAutosizingTableViewCellsSupported;
@end

@interface UIViewController (MBSetupController)

/**
    The nearest ancestor in view controller hierarchy that is setup controller.
 */
@property (nonatomic, readonly, nullable) MBSetupController *mbSetupController;

@end

@interface UIView (MBFirstResponder)
- (nullable id)mbFindFirstResponder;
@end

@interface UIViewController (MBSizeClasses)
/**
    Returns YES if current trait horizontal size class is regular
 */
- (BOOL)mbIsRegularHorizontalSizeClass;
- (BOOL)mbIsRegularVerticalSizeClass;
@end

NS_ASSUME_NONNULL_END