//
//  WeiboTabBar.h
//  Weibo_
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeiboTabBarDelegate <NSObject>

- (void)passIndex:(NSInteger)index;

@end

typedef void(^WeiboTabBarBlock)(NSInteger);

@interface WeiboTabBar : UIView

//用来传递信息
@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, weak) id <WeiboTabBarDelegate> delegate;

@property (nonatomic, copy) WeiboTabBarBlock passBlock;

@end
