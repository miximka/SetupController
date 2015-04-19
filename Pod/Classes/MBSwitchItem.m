//
//  MBSwitchItem.m
//  SetupController
//

#import "MBSwitchItem.h"
#import "MBSwitchCell.h"

@implementation MBSwitchItem

- (instancetype)initWithTitle:(NSString *)title value:(BOOL)value
{
    self = [super initWithTitle:title];
    if (self)
    {
        self.value = value;
        
        //Make text field cell non-selectable
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.createCellBlock = ^MBSetupPageCell *(MBSetupPageItem *item) {
            MBSwitchCell *cell = [[MBSwitchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:item.cellIdentifier];
            return cell;
        };

        self.configureCellBlock = ^(MBSetupPageItem *item, MBSetupPageCell *cell) {
            cell.item = item;
        };
        
        self.cellHeightBlock = ^CGFloat(UITableView *tableView, MBSetupPageItem *item, MBSetupPageCell *cell) {
            cell.item = item;
            CGSize fittingSize = CGSizeMake(tableView.bounds.size.width, 0);
            CGSize size = [cell sizeThatFits:fittingSize];
            return size.height;
        };
    }
    return self;
}

- (NSString *)cellIdentifier
{
    return @"MBSwitchCell";
}

@end
