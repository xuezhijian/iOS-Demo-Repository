//
//  CommonTableData.m
//  mycollection
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "CommonTableData.h"

#define DefaultUIRowHeight  44.f
#define DefaultUIHeaderHeight  20.f
#define DefaultUIFooterHeight  20.f

@implementation CommonTableSection

- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[Disable] boolValue]){
        return nil;
    }
    self = [super init];
    if (self){
        _headerTitle = dict[HeaderTitle];
        _footerTitle = dict[FooterTitle];
        _uiFooterHeight = [dict[FooterHeight] floatValue];
        _uiHeaderHeight = [dict[HeaderHeight] floatValue];
        _uiHeaderHeight = _uiHeaderHeight ? _uiHeaderHeight : DefaultUIHeaderHeight;
        _uiFooterHeight = _uiFooterHeight ? _uiFooterHeight : DefaultUIFooterHeight;
        _rows = [CommonTableRow rowsWithData:dict[RowContent]];
    }
    return self;
}

+ (NSArray *)sectionsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data){
        if ([dict isKindOfClass:[NSDictionary class]]){
            CommonTableSection * section = [[CommonTableSection alloc] initWithDict:dict];
            if (section){
                [array addObject:section];
            }
        }
    }
    return array;
}

@end

@implementation CommonTableRow

- (instancetype) initWithDict:(NSDictionary *)dict{
    if ([dict[Disable] boolValue]){
        return nil;
    }
    self = [super init];
    if (self){
        _title          = dict[Title];
        _detailTitle    = dict[DetailTitle];
        _cellClassName  = dict[CellClass];
        _cellActionName = dict[CellAction];
        _uiRowHeight    = dict[RowHeight] ? [dict[RowHeight] floatValue] : DefaultUIRowHeight;
        _extraInfo      = dict[ExtraInfo];
        _sepLeftEdge    = [dict[SepLeftEdge] floatValue];
        _showAccessory  = [dict[ShowAccessory] boolValue];
        _forbidSelect   = [dict[ForbidSelect] boolValue];
    }
    return self;
}

+ (NSArray *)rowsWithData:(NSArray *)data{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:data.count];
    for (NSDictionary *dict in data){
        if ([dict isKindOfClass:[NSDictionary class]]){
            CommonTableRow * row = [[CommonTableRow alloc] initWithDict:dict];
            if (row){
                [array addObject:row];
            }
        }
    }
    return array;
}

@end
