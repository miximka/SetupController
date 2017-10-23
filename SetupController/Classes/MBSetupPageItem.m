//
//  MBSetupPageItem.m
//  SetupController
//
//  Created by Maksim Bauer on 27/04/14.
//  Copyright (c) 2014 Maksim Bauer. All rights reserved.
//

#import "MBSetupPageItem.h"
#import "MBSetupPageCell.h"
#import "MBSetupPageSection.h"

@interface MBSetupPageItem ()
@property (weak, nonatomic) MBSetupPageSection *section;
@end

@implementation MBSetupPageItem

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _title = title;
        _selectionStyle = UITableViewCellSelectionStyleDefault;
        _accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)deselectAnimated:(BOOL)animated
{
    [self.section deselectItem:self animated:animated];
}

@end
