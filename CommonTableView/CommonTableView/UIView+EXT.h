//
//  UIView+EXT.h
//  mycollection
//
//  Created by zj on 16/10/14.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EXT)

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize  size;

- (UIViewController *)parentController;

@end
