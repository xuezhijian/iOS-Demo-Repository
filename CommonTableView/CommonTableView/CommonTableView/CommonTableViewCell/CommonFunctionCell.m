//
//  CommonFunctionCell.m
//  CommonTableView
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "CommonFunctionCell.h"
#import "CommonTableData.h"

@implementation CommonFunctionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)refreshData:(CommonTableRow *)rowData tableView:(UITableView *)tableView{
    self.textLabel.text = rowData.title;
    if([rowData.extraInfo isKindOfClass:[UIImage class]]){
        self.imageView.image = (UIImage*)rowData.extraInfo;
    }
}

@end
