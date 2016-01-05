//
//  PicBackgroundView.h
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicBackgroundView : UIView

//传入数字 计算出自己的高度
+ (CGFloat)heightWithNumber:(NSInteger)number;

//传入模型picuelsModel的数组 根据数组排列出内部的图片
- (void)showPicsWithArray:(NSArray *)array;

@end
