//
//  UIImage+EXT.h
//  mycollection
//
//  Created by zj on 16/10/14.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  水印方向
 */
typedef enum {
    //左上
    ImageWaterDirectTopLeft=0,
    //右上
    ImageWaterDirectTopRight,
    //左下
    ImageWaterDirectBottomLeft,
    //右下
    ImageWaterDirectBottomRight,
    //正中
    ImageWaterDirectCenter
    
}ImageWaterDirect;

@interface UIImage (EXT)

/**
 修正图片方向
 
 @return
 */
- (UIImage *)fixOrientation;


/**
 旋转图片

 @param isHorizontal 是否水平方向

 @return
 */
- (UIImage *)flip:(BOOL)isHorizontal;

/**
 自由拉伸一张图片

 @param name 图片名
 @param left 左边开始位置比例  值范围0-1
 @param top  上边开始位置比例  值范围0-1

 @return
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 等比率缩放

 @param image 要缩放的图片
 @param scale 比例

 @return
 */
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scale;

/**
 快速的返回一个最原始的图片

 @param imageNameOrPath 图片名或路径

 @return
 */
+ (UIImage *)fetchImage:(NSString *)imageNameOrPath;

/**
 生成指定颜色和指定尺寸图片
 
 @param color 颜色
 @param size  尺寸
 
 @return
 */
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
 根据CIImage生成指定大小的UIImage

 @param image CIImage
 @param size  尺寸

 @return
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

/**
 生成指定圆角度的UIImage

 @param radius 圆角度

 @return
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 根据图片返回一张高斯模糊的图片

 @param blur 模糊系数

 @return
 */
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;

/**
 转成黑白图像

 @param image 转换的图片

 @return
 */
+ (UIImage*)covertToGrayImageFromImage:(UIImage*)image;

/**
 截屏

 @return
 */
+ (UIImage *)cutScreen;

/**
 从给定UIView中截图

 @param view 给定UIView

 @return
 */
+ (UIImage *)cutFromView:(UIView *)view;


/**
 从给定UIImage和指定Frame截图

 @param frame 尺寸位置

 @return
 */
- (UIImage *)cutWithFrame:(CGRect)frame;


/**
 获取图片指定位置的颜色

 @param point 位置

 @return 
 */
- (UIColor *)colorAtPoint:(CGPoint )point;


/**
 文字水印

 @param text      文字
 @param direction 文字方向
 @param fontColor 文字颜色
 @param fontPoint 字体
 @param marginXY  对齐点

 @return 
 */
- (UIImage *)waterWithText:(NSString *)text
                 direction:(ImageWaterDirect)direction
                 fontColor:(UIColor *)fontColor
                 fontPoint:(CGFloat)fontPoint
                  marginXY:(CGPoint)marginXY;

/**
 绘制图片水印
 
 @param waterImage 图片水印
 @param direction  方向
 @param waterSize  水印大小
 @param marginXY   对齐点
 
 @return
 */
- (UIImage *)waterWithWaterImage:(UIImage *)waterImage
                       direction:(ImageWaterDirect)direction
                       waterSize:(CGSize)waterSize
                        marginXY:(CGPoint)marginXY;

/**
 播放动画(GIF)

 @param data 源文件（图片源）

 @return 
 */
+ (UIImage *)animatedGIFWithData:(NSData *)data;


/**
 播放动画(GIF)

 @param name 文件名

 @return
 */
+ (UIImage *)animatedGIFNamed:(NSString *)name;


/**
 缩放动画

 @param size 大小

 @return 
 */
- (UIImage *)animatedImageByScalingAndCroppingToSize:(CGSize)size;


/**
 图片上传前监测处理（是否是按建议的像素）

 @param suggestPixels 建议的像素，例如传1280 * 960

 @return
 */
- (UIImage *)imageForUpload: (CGFloat)suggestPixels;

/**
 按最大像素值比例转换图片

 @param maxPixels 最大像素

 @return
 */
- (UIImage *)scaleWithMaxPixels: (CGFloat)maxPixels;

/**
 按尺寸比例的内缩放图片

 @param newSize 尺寸

 @return 
 */
- (UIImage *)scaleToSize:(CGSize)newSize;

@end
