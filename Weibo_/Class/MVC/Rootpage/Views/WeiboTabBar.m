//
//  WeiboTabBar.m
//  Weibo_
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "WeiboTabBar.h"
#import "WeiboTabBarButton.h"

@interface WeiboTabBar ()

//全局数组 存放button
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation WeiboTabBar

- (NSMutableArray *)buttonArray {

    if (_buttonArray == nil) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}


- (void)setTabBarItem:(UITabBarItem *)tabBarItem {

    //获取到 title image
    //此函数调用一次创建一个Button
    WeiboTabBarButton *button = [WeiboTabBarButton buttonWithType:UIButtonTypeCustom];
    self.tabBarItem = tabBarItem;
    
    [self addSubview:button];
    button.ratio = .67;
    
    //存储在全局按钮数组里面
    [self.buttonArray addObject:button];
    
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 20, 10);
//    button.titleEdgeInsets = UIEdgeInsetsMake(20, -10, 0, 10);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //布局子视图 循环按钮数组 做相应的布局
    
    if (self.buttonArray.count == 0) {
        return;
    }
    CGFloat btnWidth = CGRectGetWidth(self.frame) / (CGFloat)self.buttonArray.count;
    for (int i = 0; i < self.buttonArray.count; i++) {
        WeiboTabBarButton *btn = self.buttonArray[i];
        CGFloat buttonX = btnWidth * i;
        CGFloat buttonY = 0;
        CGFloat buttonW = btnWidth;
        CGFloat buttonH = CGRectGetHeight(self.frame);
        
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
}

@end
