//
//  CommonTableDelegate.m
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "CommonTableDelegate.h"
#import "CommonTableData.h"
#import "CommonTableViewCellProtocol.h"
#import "UIView+EXT.h"


//消除警告宏定义
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
#define SepViewTag 10001
static NSString *DefaultTableCell = @"UITableViewCell";

@interface CommonTableDelegate ()

@property(nonatomic,copy)NSArray *(^BDDataReceiver)(void);

@end
@implementation CommonTableDelegate

-  (instancetype) initWithTableData:(NSArray *(^)(void))data{
    self = [super init];
    if (self){
        _BDDataReceiver = data;
        _defaultSeparatorLeftEdge = SepLineLeft;
    }
    return self;
}

- (NSArray *)data{
    return self.BDDataReceiver();
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    return tableSection.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonTableSection *tableSection = self.data[indexPath.section];
    CommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    NSString *identity                 = tableRow.cellClassName.length ? tableRow.cellClassName : DefaultTableCell;
    UITableViewCell *cell              = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell){
        Class clazz                      = NSClassFromString(identity);
        cell                             = [[clazz alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identity];
        UIView *sep                      = [[UIView alloc] initWithFrame:CGRectZero];
        sep.tag                          = SepViewTag;
        sep.autoresizingMask             = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        //你可以改变分割线的颜色,我是用了宏UIColorFromRGB(0xc8c7cc)，demo为了不依赖就直接计算吧
        sep.backgroundColor              = [UIColor colorWithRed:((float)((0xc8c7cc & 0xFF0000) >> 16))/255.0 green:((float)((0xc8c7cc & 0xFF00) >> 8))/255.0 blue:((float)(0xc8c7cc & 0xFF))/255.0 alpha:1.0];
        [cell addSubview:sep];
    }
    if (![cell respondsToSelector:@selector(refreshData:tableView:)]){
        UITableViewCell *defaultCell   = (UITableViewCell *)cell;
        [self refreshData:tableRow cell:defaultCell];
    }else{
        [(id<CommonTableViewCellProtocol>)cell refreshData:tableRow tableView:tableView];
    }
    cell.accessoryType  = tableRow.showAccessory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommonTableSection *tableSection = self.data[indexPath.section];
    CommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    return tableRow.uiRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CommonTableSection *tableSection = self.data[indexPath.section];
    CommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    if (!tableRow.forbidSelect){
        UIViewController *vc = tableView.parentController;
        NSString *actionName = tableRow.cellActionName;
        if (actionName.length){
            SEL sel = NSSelectorFromString(actionName);
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            SuppressPerformSelectorLeakWarning([vc performSelector:sel withObject:cell]);
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里的cell已经有了正确的bounds
    //不在cellForRow的地方设置分割线是因为在ios7下，0.5像素的view利用autoResizeMask调整布局有问题，会导致显示不出来，ios6,ios8均正常。
    //具体问题类似http://stackoverflow.com/questions/30663733/add-a-0-5-point-height-subview-to-uinavigationbar-not-show-in-ios7
    //这个回调里调整分割线的位置
    CommonTableSection *tableSection = self.data[indexPath.section];
    CommonTableRow     *tableRow     = tableSection.rows[indexPath.row];
    UIView *sep = [cell viewWithTag:SepViewTag];
    CGFloat sepHeight = .5f;
    CGFloat sepWidth;
    if (tableRow.sepLeftEdge) {
        sepWidth  = cell.width - tableRow.sepLeftEdge;
    }else{
        CommonTableSection *section = self.data[indexPath.section];
        if (indexPath.row == section.rows.count - 1){
            sepWidth = 0;//最后一行
        }else{
            sepWidth = cell.width - self.defaultSeparatorLeftEdge;
        }
    }
    sepWidth  = sepWidth > 0 ? sepWidth : 0;
    sep.frame = CGRectMake(cell.width - sepWidth, cell.height - sepHeight, sepWidth ,sepHeight);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    return tableSection.headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    return tableSection.uiHeaderHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    return tableSection.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    return tableSection.uiFooterHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    if (tableSection.headerTitle.length){
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CommonTableSection *tableSection = self.data[section];
    if (tableSection.footerTitle.length){
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

//返回每一行的估计高度，提高性能
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma mark - Private
- (void)refreshData:(CommonTableRow *)rowData cell:(UITableViewCell *)cell{
    cell.textLabel.text = rowData.title;
    cell.detailTextLabel.text = rowData.detailTitle;
}

@end
