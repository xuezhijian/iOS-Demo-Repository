//
//  NSMutableAttributedString+BDExtension.m
//  BDIos
//
//  Created by zj on 16/8/22.
//  Copyright © 2016年 bedekeji. All rights reserved.
//

#import "NSMutableAttributedString+BDExtension.h"


@implementation NSMutableAttributedString (BDExtension)

- (void)bd_setTextColor:(UIColor*)color
{
    [self bd_setTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)bd_setTextColor:(UIColor*)color range:(NSRange)range
{
    if (color.CGColor)
    {
        [self removeAttribute:(NSString *)kCTForegroundColorAttributeName range:range];
        
        [self addAttribute:(NSString *)kCTForegroundColorAttributeName
                     value:(id)color.CGColor
                     range:range];
    }
    
}

- (void)bd_setFont:(UIFont*)font
{
    [self bd_setFont:font range:NSMakeRange(0, [self length])];
}

- (void)bd_setFont:(UIFont*)font range:(NSRange)range
{
    if (font)
    {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
        
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)font.fontName, font.pointSize, nil);
        if (nil != fontRef)
        {
            [self addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)fontRef range:range];
            CFRelease(fontRef);
        }
    }
}

- (void)bd_setUnderlineStyle:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier
{
    [self bd_setUnderlineStyle:style modifier:modifier range:NSMakeRange(0, self.length)];
}

- (void)bd_setUnderlineStyle:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier range:(NSRange)range
{
    [self removeAttribute:(NSString *)kCTUnderlineColorAttributeName range:range];
    [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                 value:[NSNumber numberWithInt:(style|modifier)]
                 range:range];
}

@end
