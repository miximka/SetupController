//
//  MBSetupController.h
//  SetupController
//
//  Created by Maksim Bauer on 26/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBSetupControllerDataSource;
@protocol MBSetupControllerDelegate;

#pragma mark - MBPage

@protocol MBPage <NSObject>
/**
    Indicates whether setup controller should remove the receiver from stack when its done (i.e. another page controller has been pushed on stack above it)
 */
@property (nonatomic) BOOL removeWhenDone;

/**
    Will be set to YES if receiver has been skipped.
 */
@property (nonatomic, readonly, getter=isSkipped) BOOL skipped;
@end

#pragma mark - MBSetupController

@interface MBSetupController : UIViewController

@property (weak, nonatomic) id<MBSetupControllerDataSource> dataSource;
@property (weak, nonatomic) id<MBSetupControllerDelegate> delegate;

#pragma mark - Customizing Appearance

@property (nonatomic, readonly) UINavigationController *setupNavigationController;

#pragma mark - Providing Content

/**
    The view controllers currently on the stack.
    Controllers should implement MBPage protocol.
 */
@property (nonatomic, readonly) NSArray *viewControllers;
- (void)setViewControllers:(NSArray *)controllers animated:(BOOL)animated;

#pragma mark - Navigating

/**
    Pop current view controller from stack.
 */
- (void)popBack;

/**
    Push next view controller on stack.
 */
- (void)pushNext;

@end

#pragma mark - Protocols

@protocol MBSetupControllerDataSource <NSObject>
- (UIViewController<MBPage> *)setupController:(MBSetupController *)setupController viewControllerAfterViewController:(UIViewController<MBPage> *)viewController;
@end

@protocol MBSetupControllerDelegate <NSObject>
@optional
- (void)setupController:(MBSetupController *)setupController willShowViewController:(UIViewController<MBPage> *)viewController animated:(BOOL)animated;
- (void)setupController:(MBSetupController *)setupController didShowViewController:(UIViewController<MBPage> *)viewController animated:(BOOL)animated;
- (void)setupControllerDidFinish:(MBSetupController *)setupController;
@end