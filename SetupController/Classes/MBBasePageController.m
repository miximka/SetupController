//
//  MBBasePageController.m
//  SetupController
//
//  Created by Maksim Bauer on 29/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBBasePageController.h"
#import "MBSetupControllerUtilities.h"

#define PAGE_DEFAULT_HORIZONTAL_MARGIN 100.0

@interface MBSetupController (Friend)
- (void)pageControllerProceedToPreviousPage:(UIViewController *)controller;
- (void)pageControllerProceedToNextPage:(UIViewController *)controller;
@end

@interface MBBasePageController ()
@property (nonatomic) NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic) NSLayoutConstraint *rightMarginConstraint;
@end

@implementation MBBasePageController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _horizontalMargin = PAGE_DEFAULT_HORIZONTAL_MARGIN;
        _automaticallyAdjustMargins = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _horizontalMargin = PAGE_DEFAULT_HORIZONTAL_MARGIN;
        _automaticallyAdjustMargins = YES;
    }
    return self;
}

- (void)setHidesBackButton:(BOOL)hide
{
    _hidesBackButton = hide;
    self.navigationItem.hidesBackButton = hide;
}

- (void)setHidesNextButton:(BOOL)hide
{
    _hidesNextButton = hide;
    [self configureBarButtonItemsAnimated:NO];
}

- (void)configureBarButtonItemsAnimated:(BOOL)animate
{
    if (!_nextButtonItem) {
        _nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextTap:)];
    }

    UINavigationItem *navItem = self.navigationItem;
    navItem.hidesBackButton = self.hidesBackButton;

    BOOL shouldPresentNextButton = !self.hidesNextButton;
    BOOL presentingNextButton = [navItem.rightBarButtonItems containsObject:_nextButtonItem];
    
    NSMutableArray *mutableRightBarButtonItems = [navItem.rightBarButtonItems mutableCopy];
    
    if (shouldPresentNextButton && !presentingNextButton) {
        //Add next button
        if (!mutableRightBarButtonItems) {
            mutableRightBarButtonItems = [NSMutableArray new];
        }
        
        [mutableRightBarButtonItems addObject:_nextButtonItem];
        [navItem setRightBarButtonItems:mutableRightBarButtonItems animated:animate];
    } else {
        //Remove next button
        [mutableRightBarButtonItems removeObject:_nextButtonItem];
        [navItem setRightBarButtonItems:mutableRightBarButtonItems animated:animate];
    }
}

- (IBAction)nextTap:(id)sender
{
    BOOL success = YES;
    
    UIView *firstResponder = [self.view mbFindFirstResponder];
    if (firstResponder) {
        success = [firstResponder resignFirstResponder];
    }
    
    [self handleNextButtonTap];
}

- (void)adjustMargins
{
    if (!self.automaticallyAdjustMargins) {
        return;
    }
    
    CGFloat margin = 0.0;
    if (self.mbIsRegularHorizontalSizeClass) {
        margin = self.horizontalMargin;
    }
    
    _leftMarginConstraint.constant = margin;
    _rightMarginConstraint.constant = margin;
}

- (void)addContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:contentView];
    
    _leftMarginConstraint = [NSLayoutConstraint constraintWithItem:contentView
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1.0
                                                          constant:0];
    [self.view addConstraint:_leftMarginConstraint];
    
    _rightMarginConstraint = [NSLayoutConstraint constraintWithItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:contentView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0];
    [self.view addConstraint:_rightMarginConstraint];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentView)]];
    _contentView = contentView;
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self addContentView];
    [self configureBarButtonItemsAnimated:NO];
    [self adjustMargins];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    [self adjustMargins];
}

#pragma mark - Navigation

- (void)handleNextButtonTap
{
    [self proceedToNextPage];
}

- (void)proceedToPreviousPage
{
    [self.mbSetupController pageControllerProceedToPreviousPage:self];
}

- (void)proceedToNextPage
{
    [self.mbSetupController pageControllerProceedToNextPage:self];
}

- (void)skip
{
    _skipped = YES;
    [self.mbSetupController pageControllerProceedToNextPage:self];
}

@end
