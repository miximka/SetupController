//
//  MBSetupPageController.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBTableViewPageController.h"
#import "MBSectionHeader.h"
#import "MBSectionFooter.h"
#import "MBSetupPageSection.h"
#import "MBSetupPageItem.h"
#import "MBSetupPageCell.h"
#import "MBSetupControllerUtilities.h"

#define MINIMUM_CELL_HEIGHT     44.0
#define MINIMUM_HEADER_HEIGHT   22.0
#define MINIMUM_FOOTER_HEIGHT   22.0

#define HEADER_VIEW_LABEL_REGULAR_CLASS_MARGIN 60.0

@interface MBSetupPageSection (Friend)
@property (weak, nonatomic) MBBasePageController *parentController;
@end

@interface MBSetupPageCell (Friend)
- (void)_cellWillAppear;
@end

@interface MBTableViewPageController ()
@property (nonatomic) NSMutableArray *mutableSections;
@property (nonatomic) UITextField *activeField;
@end

@implementation MBTableViewPageController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configurePageController];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self configurePageController];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configurePageController
{
    _useAutosizingCells = [MBSetupControllerUtilities isAutosizingTableViewCellsSupported];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowNotification:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditingNotification:)
                                                 name:UITextFieldTextDidBeginEditingNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEditingNotification:)
                                                 name:UITextFieldTextDidEndEditingNotification object:nil];
}

- (void)addTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.estimatedRowHeight = 44.0;
    tableView.rowHeight = UITableViewAutomaticDimension;
    
    //Turn off default separators because table adds separator also above first row and we don't want to have it.
    //Custom separators are added manually during cell creation.
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *contentView = self.contentView;
    
    [contentView addSubview:tableView];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];

    tableView.dataSource = self;
    tableView.delegate = self;

    _tableView = tableView;
}

- (MBSectionHeader *)preparedPageHeaderViewWithTitle:(NSString *)title
{
    MBSectionHeader *view = [[MBSectionHeader alloc] init];
    view.titleLabel.text = title;

    if (self.mbIsRegularVerticalSizeClass) {
        //We have a lot of vertical space when in a regular size class, so push the things a bit apart
        view.titleLabelInset = UIEdgeInsetsMake(HEADER_VIEW_LABEL_REGULAR_CLASS_MARGIN, 0, HEADER_VIEW_LABEL_REGULAR_CLASS_MARGIN, 0);
    }
    
    return view;
}

- (MBSectionFooter *)preparedFooterViewWithImage:(UIImage *)image title:(NSString *)title subtitle:(NSString *)subtitle
{
    MBSectionFooter *footer = [[MBSectionFooter alloc] init];
    
    footer.imageView.image = image;
    footer.imageView.hidden = image == nil;
    
    footer.titleLabel.text = title;
    footer.titleLabel.hidden = title.length == 0;

    footer.subtitleLabel.text = subtitle;
    footer.subtitleLabel.hidden = subtitle.length == 0;
    
    return footer;
}

#pragma mark - Providing Table View Content

- (NSArray *)sections
{
    return [_mutableSections copy];
}

- (void)setSections:(NSArray *)sections
{
    for (MBSetupPageSection *each in sections) {
        each.parentController = self;
    }
    
    _mutableSections = [sections mutableCopy];
    [self.tableView reloadData];
}

- (MBSetupPageItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    MBSetupPageSection *section = _mutableSections[indexPath.section];
    MBSetupPageItem *item = section.items[indexPath.row];

    return item;
}

#pragma mark - Validation

- (BOOL)validate
{
    BOOL success = YES;
    
    for (MBSetupPageSection *each in self.sections) {
        success &= each.validate;
    }

    return success;
}

#pragma mark - Overridden Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self validate];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _mutableSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    MBSetupPageSection *section = _mutableSections[sectionIndex];
    return section.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBSetupPageItem *item = [self itemAtIndexPath:indexPath];
    NSAssert(item.cellIdentifier != nil, @"cellIdentifier != nil not satisfied");
    
    MBSetupPageCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier];
    if (!cell) {
        cell = item.createCellBlock(item);
    }
    
    item.configureCellBlock(item, cell);
    [cell _cellWillAppear];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    MBSetupPageSection *section = _mutableSections[sectionIndex];
    
    UIView *view = nil;
    if (section.headerViewBlock) {
        view = section.headerViewBlock(section);
    }
    
    CGFloat height = 0;
    
    if (view && section.headerHeightBlock) {
        height = section.headerHeightBlock(tableView, section, view);
    }
    
    if (height == 0) {
        height = MINIMUM_HEADER_HEIGHT;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    MBSetupPageSection *section = _mutableSections[sectionIndex];

    UIView *view = nil;
    if (section.footerViewBlock) {
        view = section.footerViewBlock(section);
    }
    
    CGFloat height = 0;

    if (view && section.footerHeightBlock) {
        height = section.footerHeightBlock(tableView, section, view);
    }

    if (height == 0) {
        height = MINIMUM_FOOTER_HEIGHT;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    MBSetupPageSection *section = _mutableSections[sectionIndex];

    UIView *view = nil;
    if (section.headerViewBlock) {
        view = section.headerViewBlock(section);
    }
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex
{
    MBSetupPageSection *section = _mutableSections[sectionIndex];
    
    UIView *view = nil;
    if (section.footerViewBlock) {
        view = section.footerViewBlock(section);
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.useAutosizingCells) {
        return UITableViewAutomaticDimension;
    }
    
    MBSetupPageItem *item = [self itemAtIndexPath:indexPath];
    NSAssert(item.cellIdentifier != nil, @"cellIdentifier != nil not satisfied");
    
    MBSetupPageCell *cell = [tableView dequeueReusableCellWithIdentifier:item.cellIdentifier];
    if (!cell) {
        cell = item.createCellBlock(item);
    }
    
    item.configureCellBlock(item, cell);
    
    CGFloat height = 0;
    
    if (cell) {
        NSAssert(item.cellHeightBlock != nil, @"item.cellHeightBlock != nil not satisfied");
        height = item.cellHeightBlock(tableView, item, cell);
    }
    if (height == 0) {
        height = MINIMUM_CELL_HEIGHT;
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBSetupPageItem *item = [self itemAtIndexPath:indexPath];
    
    if (item.didSelectBlock) {
        item.didSelectBlock(item);
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditingNotification:(NSNotification *)notification
{
    self.activeField = notification.object;
}

- (void)textFieldDidEndEditingNotification:(NSNotification *)notification
{
    self.activeField = nil;
}

#pragma mark - Keyboard Notifications

- (void)keyboardDidShowNotification:(NSNotification *)notification
{
    UIScrollView *scrollView = self.tableView;
    
    CGRect keyboardRect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];

    //Update scroll view inset
    UIEdgeInsets contentInsets = scrollView.contentInset;
    contentInsets.bottom = keyboardRect.size.height;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;

    //Scroll to active text field
    CGRect visibleFrame = self.view.frame;
    visibleFrame.size.height -= keyboardRect.size.height;
    CGRect activeFieldFrame = [self.view convertRect:self.activeField.frame fromView:self.activeField.superview];
    
    if (!CGRectContainsPoint(visibleFrame, activeFieldFrame.origin)) {
        activeFieldFrame = [scrollView convertRect:self.activeField.frame fromView:self.activeField.superview];
        [scrollView scrollRectToVisible:activeFieldFrame animated:YES];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    UIScrollView *scrollView = self.tableView;
    UIEdgeInsets contentInsets = scrollView.contentInset;
    contentInsets.bottom = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }];
}

@end
