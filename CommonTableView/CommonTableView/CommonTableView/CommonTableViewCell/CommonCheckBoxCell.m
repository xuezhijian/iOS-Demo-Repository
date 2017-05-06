//
//  CommonCheckBoxCell.m
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "CommonCheckBoxCell.h"
#import "UIView+EXT.h"

@interface CommonCheckBoxCell ()

@property(nonatomic,strong)UIButton* checkBox;

@end
@implementation CommonCheckBoxCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backgroundImage = [UIImage imageNamed:[BundleName stringByAppendingPathComponent:@"common_checkbox_background"]];
        _checkBox.size = backgroundImage.size;
        [_checkBox setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [_checkBox setBackgroundImage:backgroundImage forState:UIControlStateHighlighted];
        [_checkBox setBackgroundImage:backgroundImage forState:UIControlStateSelected];
        [_checkBox setImage:[UIImage imageNamed:[BundleName stringByAppendingPathComponent:@"common_checkbox_unselected"]] forState:UIControlStateNormal];
        [_checkBox setImage:[UIImage imageNamed:[BundleName stringByAppendingPathComponent:@"common_checkbox_selected"]] forState:UIControlStateSelected];
        [_checkBox setImage:[UIImage imageNamed:[BundleName stringByAppendingPathComponent:@"common_checkbox_selected"]] forState:UIControlStateHighlighted];
        [self addSubview:_checkBox];
    }
    return self;
}

- (void)refreshData:(CommonTableRow *)rowData tableView:(UITableView *)tableView{
    self.textLabel.text    = rowData.title;
    self.checkBox.selected = [rowData.extraInfo boolValue];
    [self.checkBox removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    NSString *actionName   = rowData.cellActionName;
    if (actionName.length) {
        SEL sel = NSSelectorFromString(actionName);
        [self.checkBox addTarget:tableView.parentController action:sel forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat checkBoxRight         = 17.f;
    self.checkBox.right   = self.contentView.width - checkBoxRight;
    self.checkBox.centerY = self.contentView.height * .5;
}


@end
