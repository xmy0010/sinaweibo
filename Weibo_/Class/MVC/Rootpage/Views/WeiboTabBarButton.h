//
//  WeiboTabBarButton.h
//  Weibo_
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTabBarButton : UIButton

//图片高度占整个按钮的比例 0~1  default 0.6
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) UITabBarItem * tabBarItem;

@end
