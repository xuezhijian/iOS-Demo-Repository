//
//  NSMutableAttributedString+BDExtension.h
//  BDIos
//
//  Created by zj on 16/8/22.
//  Copyright © 2016年 bedekeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (BDExtension)

- (void) bd_setTextColor:(UIColor*)color;
- (void) bd_setTextColor:(UIColor*)color range:(NSRange)range;
- (void) bd_setFont:(UIFont*)font;
- (void) bd_setFont:(UIFont*)font range:(NSRange)range;
- (void) bd_setUnderlineStyle:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier;
- (void) bd_setUnderlineStyle:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier range:(NSRange)range;

@end
