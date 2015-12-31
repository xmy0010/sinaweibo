//
//  UIBarButtonItem+Util.m
//  Weibo_
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "UIBarButtonItem+Util.h"

@implementation UIBarButtonItem (Util)

//传入图片名称创建UIBarButtonItem
+ (instancetype)generateBarButtonItemWithNormalImageName: (NSString *)norImageName highlightedImageName:(NSString *)hlimageName target:(id)target selector:(SEL)sel{
    
    //1.创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hlimageName] forState:UIControlStateHighlighted];
    CGSize imageSize = button.currentImage.size;
    button.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    //2.创建  UIBarButtonItem对象并返回
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

@end
