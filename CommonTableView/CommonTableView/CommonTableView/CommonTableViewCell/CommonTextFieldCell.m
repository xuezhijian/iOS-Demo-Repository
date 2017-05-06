//
//  CommonTextFieldCell.m
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "CommonTextFieldCell.h"
#import "UIView+EXT.h"

@interface CommonTextFieldCell ()

@property(nonatomic,strong)UITextField *textField;

@end
@implementation CommonTextFieldCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField                 = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.font            = [UIFont systemFontOfSize:17.f];
        _textField.textColor       = [UIColor grayColor];
        _textField.tintColor       = [UIColor blackColor];
        [self addSubview:_textField];
    }
    return self;
}


- (void)refreshData:(CommonTableRow *)rowData tableView:(UITableView *)tableView{
    _textField.delegate    = (id<UITextFieldDelegate>)tableView.parentController;
    _textField.placeholder = rowData.detailTitle;
    _textField.text        = rowData.title;
    _textField.returnKeyType   = [rowData.extraInfo integerValue];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat textFieldLeft   = 17.f;
    CGFloat textFieldRight  = 17.f;
    self.textField.width  = self.contentView.width - textFieldLeft - textFieldRight;
    self.textField.height = 44.f;
    self.textField.centerX = self.width * .5f;
    self.textField.centerY = self.height * .5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (selected) {
        [self.textField becomeFirstResponder];
    }
}


@end
