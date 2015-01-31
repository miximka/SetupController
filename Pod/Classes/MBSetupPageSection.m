//
//  MBSetupPageSection.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageSection.h"
#import "MBSetupPageItem.h"
#import "MBTableViewPageController.h"

@interface MBSetupPageItem (Friend)
@property (weak, nonatomic) MBSetupPageSection *section;
@end

@interface MBSetupPageSection ()
@property (weak, nonatomic) MBTableViewPageController *parentController;
@property (nonatomic) NSMutableArray *mutableItems;
@end

@implementation MBSetupPageSection

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

+ (instancetype)sectionWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title];
}

#pragma mark - Providing Section Items

- (NSArray *)items
{
    return [_mutableItems copy];
}

- (void)setItems:(NSArray *)items
{
    _mutableItems = [items mutableCopy];

    for (MBSetupPageItem *each in _mutableItems) {
        each.section = self;
    }
}

- (NSIndexPath *)indexPathForItem:(MBSetupPageItem *)item
{
    NSInteger sectionIndex = [self.parentController.sections indexOfObject:self];
    NSInteger itemIndex = [self.items indexOfObject:item];
    
    if (sectionIndex == NSNotFound || itemIndex == NSNotFound) {
        return nil;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:sectionIndex];
    return indexPath;
}

#pragma mark - Validation

- (BOOL)validate
{
    BOOL success = YES;
    for (MBSetupPageItem *each in self.items) {
        if (each.validateBlock) {
            success &= each.validateBlock(each);
            if (!success) { break; }
        }
    }
    
    return success;
}

#pragma mark - Handling Selection

- (void)deselectItem:(MBSetupPageItem *)item animated:(BOOL)animated
{
    NSIndexPath *indexPath = [self indexPathForItem:item];
    [self.parentController.tableView deselectRowAtIndexPath:indexPath animated:animated];
}

@end
