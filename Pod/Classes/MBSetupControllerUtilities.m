//
//  MBSetupControllerUtilities.m
//  SetupController
//
//  Created by Maksim Bauer on 30/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupControllerUtilities.h"
#import "MBSetupController.h"

@implementation MBSetupControllerUtilities

+ (UILabel *)captionStyledLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    return label;
}

+ (BOOL)isAutosizingTableViewCellsSupported
{
    //We are on iOS8 or later
    return [UITraitCollection class] != nil;
}

@end

@implementation UIViewController (SetupController)

- (MBSetupController *)mbSetupController
{
    UIViewController *parent = self.parentViewController;
    if ([parent isKindOfClass:[MBSetupController class]]) {
        return (MBSetupController *)parent;
    }
    
    return parent.mbSetupController;
}

@end

@implementation UIView (MBFirstResponder)

- (id)mbFindFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView mbFindFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

@end

@implementation UIViewController (MBSizeClasses)

- (BOOL)mbIsRegularHorizontalSizeClass
{
    BOOL isRegular = NO;
    
    if ([UITraitCollection class]) {
        //iOS 8 or later
        UITraitCollection *traits = self.traitCollection;
        isRegular = traits.horizontalSizeClass == UIUserInterfaceSizeClassRegular;
    } else {
        //iOS 7 or earlier
        isRegular = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    }
    
    return isRegular;
}

- (BOOL)mbIsRegularVerticalSizeClass
{
    BOOL isRegular = NO;
    
    if ([UITraitCollection class]) {
        //iOS 8 or later
        UITraitCollection *traits = self.traitCollection;
        isRegular = traits.verticalSizeClass == UIUserInterfaceSizeClassRegular;
    } else {
        //iOS 7 or earlier
        isRegular = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    }
    
    return isRegular;
}

@end
