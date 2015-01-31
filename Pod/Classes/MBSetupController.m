//
//  MBSetupController.m
//  SetupController
//
//  Created by Maksim Bauer on 26/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupController.h"
#import "MBTableViewPageController.h"

@interface MBSetupController () <UINavigationControllerDelegate>
@end

@implementation MBSetupController

- (void)setNavController:(UINavigationController *)controller
{
    if (_setupNavigationController == controller) {
        return;
    }
    
    [_setupNavigationController willMoveToParentViewController:nil];
    [_setupNavigationController.view removeFromSuperview];
    [_setupNavigationController removeFromParentViewController];
    _setupNavigationController.delegate = nil;
    
    _setupNavigationController = controller;
    controller.delegate = self;
    
    [self addChildViewController:controller];
    
    UIView *view = controller.view;
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:view];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(view);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
    
    [controller didMoveToParentViewController:self];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Providing Content

- (NSArray *)viewControllers
{
    return self.setupNavigationController.viewControllers;
}

- (void)setViewControllers:(NSArray *)controllers animated:(BOOL)animated
{
    [self.setupNavigationController setViewControllers:controllers animated:animated];
}

#pragma mark - Navigating

- (void)popBack
{
    [self.setupNavigationController popViewControllerAnimated:YES];
}

- (void)pushNext
{
    UIViewController<MBPage> *topController = (UIViewController<MBPage> *)self.setupNavigationController.topViewController;
    UIViewController<MBPage> *nextController = [self.dataSource setupController:self viewControllerAfterViewController:topController];
    if (nextController) {
        [self.setupNavigationController pushViewController:nextController animated:YES];
    } else {
        //No more controllers to present, so setup is finished
        if ([self.delegate respondsToSelector:@selector(setupControllerDidFinish:)]) {
            [self.delegate setupControllerDidFinish:self];
        }
    }
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationController *controller = [[UINavigationController alloc] init];
    
    //White navigation bar background
    UIImage *whiteImage = [self imageWithColor:[UIColor whiteColor]];
    [controller.navigationBar setBackgroundImage:whiteImage forBarMetrics:UIBarMetricsDefault];
    controller.navigationBar.shadowImage = [UIImage new];
    
    [self setNavController:controller];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.viewControllers.count == 0) {
        UIViewController *initialViewController = [self.dataSource setupController:self viewControllerAfterViewController:nil];
        if (initialViewController) {
            [self setViewControllers:@[initialViewController] animated:NO];
        }
    }
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController<MBPage> *)viewController animated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(setupController:willShowViewController:animated:)]) {
        [self.delegate setupController:self willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController<MBPage> *)viewController animated:(BOOL)animated
{
    if ([self.delegate respondsToSelector:@selector(setupController:didShowViewController:animated:)]) {
        [self.delegate setupController:self didShowViewController:viewController animated:animated];
    }
    
    UIViewController<MBPage> *previousViewController = nil;
    if (navigationController.viewControllers.count > 1) {
        previousViewController = (UIViewController<MBPage> *)navigationController.viewControllers[navigationController.viewControllers.count - 2];
        
        if (previousViewController.removeWhenDone) {
            NSMutableArray *controllers = [navigationController.viewControllers mutableCopy];
            [controllers removeObject:previousViewController];
            [navigationController setViewControllers:controllers animated:NO];
        }
    }
}

@end

@implementation MBSetupController (Friend)

- (void)pageControllerProceedToPreviousPage:(UIViewController *)controller
{
    [self popBack];
}

- (void)pageControllerProceedToNextPage:(UIViewController *)controller
{
    [self pushNext];
}

@end
