//
//  MBBasePageController.h
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupController.h"

@interface MBBasePageController : UIViewController <MBPage>

/**
    Content view of the receiver. Content view is the default superview for content dispayed by the receiver's view.
 */
@property (nonatomic, readonly, nullable) UIView *contentView;

#pragma mark - Customizing Appearance

/**
    Horizontal margin to be set in a regular size class environment.
 */
@property (nonatomic) CGFloat horizontalMargin;

/**
    Set to YES to let controller automatically increase horizontal margin between superview and controller's view when in regular horizontal size class.
 */
@property (nonatomic) BOOL automaticallyAdjustMargins;

/**
    A Boolean value that determines whether the back button is hidden.
 */
@property (nonatomic) BOOL hidesBackButton;

/**
    Bar button item presented on the right of the navigation bar when receiver is on the top of the setup controller stack.
 */
@property (nonatomic, nullable) UIBarButtonItem *nextButtonItem;

/**
    A Boolean value that determines whether the next button is hidden.
 */
@property (nonatomic) BOOL hidesNextButton;

#pragma mark - Navigation

/**
    Called when next bar button item is tapped.
    Default implementation simply calls -proceedToNextPage
 */
- (void)handleNextButtonTap;

/**
    Call this to proceed to the previous page controller.
 */
- (void)proceedToPreviousPage;

/**
    Call this to proceed to the next page controller.
 */
- (void)proceedToNextPage;

/**
    Indicates whether setup controller should remove the receiver from stack when its done (i.e. another controller has been pushed on stack above it due proceedToNextPage call)
    Default is NO.
 */
@property (nonatomic) BOOL removeWhenDone;

/**
    Will be set to YES if receiver has been skipped.
 */
@property (nonatomic, readonly, getter=isSkipped) BOOL skipped;

/**
    Call this to skip the optional receiver.
 */
- (void)skip;

@end
