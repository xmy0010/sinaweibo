//
//  DropControl.h
//  Weibo_
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropControl : UIControl

/**
 *
 *  @param frame 内部显示出来的选项的位置
 *  @param view  DropView加载的父视图
 *
 */
- (instancetype)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)view;

//显示
- (void)show;

//消失
- (void)dismiss;

@end
