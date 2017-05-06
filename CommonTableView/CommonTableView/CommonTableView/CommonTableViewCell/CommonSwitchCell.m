//
//  CommonSwitchCell.m
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "CommonSwitchCell.h"
#import "UIView+EXT.h"

@interface CommonSwitchCell ()

@property(nonatomic,strong)UISwitch *switchButton;

@end
@implementation CommonSwitchCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _switchButton  = [[UISwitch alloc] initWithFrame:CGRectZero];
        [self addSubview:_switchButton];
    }
    return self;
}

- (void)refreshData:(CommonTableRow *)rowData tableView:(UITableView *)tableView{
    self.textLabel.text = rowData.title;
    [self.switchButton setOn:[rowData.extraInfo boolValue]];
    [self.switchButton removeTarget:self action:NULL forControlEvents:UIControlEventValueChanged];
    NSString *actionName   = rowData.cellActionName;
    if (actionName.length) {
        SEL sel = NSSelectorFromString(actionName);
        [self.switchButton addTarget:tableView.parentController action:sel forControlEvents:UIControlEventValueChanged];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat switchWidth       = 51.f;
    CGFloat switchHeight      = 31.f;
    CGFloat switchRight       = 17.f;
    
    self.switchButton.width   = switchWidth;
    self.switchButton.height  = switchHeight;
    self.switchButton.right   = self.contentView.width - switchRight;
    self.switchButton.centerY = self.contentView.height * .5f;
}

@end
