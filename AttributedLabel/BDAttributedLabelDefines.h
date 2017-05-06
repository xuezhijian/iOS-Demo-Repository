//
//  BDAttributedLabelDefines.h
//  BDIos
//
//  Created by zj on 16/8/22.
//  Copyright © 2016年 bedekeji. All rights reserved.
//

#ifndef BDAttributedLabelDefines_h
#define BDAttributedLabelDefines_h

typedef enum
{
    BDImageAlignmentTop,
    BDImageAlignmentCenter,
    BDImageAlignmentBottom
} BDImageAlignment;

@class BDAttributedLabel;

@protocol BDAttributedLabelDelegate <NSObject>

- (void)nimAttributedLabel:(BDAttributedLabel *)label clickedOnLink:(id)linkData;

@end

typedef NSArray *(^BDCustomDetectLinkBlock)(NSString *text);

//如果文本长度小于这个值,直接在UI线程做Link检测,否则都dispatch到共享线程
#define BDMinAsyncDetectLinkLength 50

#define IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)


#endif /* BDAttributedLabelDefines_h */
