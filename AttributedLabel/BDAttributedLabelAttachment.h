//
//  BDAttributedLabelAttachment.h
//  BDIos
//
//  Created by zj on 16/8/22.
//  Copyright © 2016年 bedekeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDAttributedLabelDefines.h"

void BDDeallocCallback(void* ref);
CGFloat BDAscentCallback(void *ref);
CGFloat BDDescentCallback(void *ref);
CGFloat BDWidthCallback(void* ref);

@interface BDAttributedLabelAttachment : NSObject

@property (nonatomic,strong) id                content;
@property (nonatomic,assign) UIEdgeInsets      margin;
@property (nonatomic,assign) BDImageAlignment  alignment;
@property (nonatomic,assign) CGFloat           fontAscent;
@property (nonatomic,assign) CGFloat           fontDescent;
@property (nonatomic,assign) CGSize            maxSize;

+ (BDAttributedLabelAttachment *)attachmentWith: (id)content margin: (UIEdgeInsets)margin alignment: (BDImageAlignment)alignment maxSize: (CGSize)maxSize;
- (CGSize)boxSize;

@end
