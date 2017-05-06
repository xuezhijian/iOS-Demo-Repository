//
//  CommonTableDelegate.h
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableDelegate : NSObject<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) CGFloat defaultSeparatorLeftEdge;

- (instancetype) initWithTableData:(NSArray *(^)(void))data;

@end
