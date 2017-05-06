//
//  BDAttributedLabelURL.h
//  BDIos
//
//  Created by zj on 16/8/22.
//  Copyright © 2016年 bedekeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDAttributedLabelDefines.h"

@interface BDAttributedLabelURL : NSObject

@property (nonatomic,strong) id      linkData;
@property (nonatomic,assign) NSRange range;
@property (nonatomic,strong) UIColor *color;

+ (BDAttributedLabelURL *)urlWithLinkData: (id)linkData range: (NSRange)range color: (UIColor *)color;

+ (NSArray *)detectLinks: (NSString *)plainText;
+ (void)setCustomDetectMethod:(BDCustomDetectLinkBlock)block;

@end
