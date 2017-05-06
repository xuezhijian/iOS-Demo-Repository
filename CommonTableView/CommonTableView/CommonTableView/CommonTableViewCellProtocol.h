//
//  CommonTableViewCellProtocol.h
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTableData.h"

#define BundleName @"CommonTableViewResouce.bundle"
@protocol CommonTableViewCellProtocol <NSObject>

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@optional
- (void)refreshData:(CommonTableRow *)rowData tableView:(UITableView *)tableView;

@end
