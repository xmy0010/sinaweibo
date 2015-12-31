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
@property (nonatomic, strong) WeiboTabBarButton *selectedButton;

//中间的加号按钮
@property (nonatomic, strong) UIButton *plusButton;


@end

@implementation WeiboTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //创建一个按钮 设置一次性的属性
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:plusButton];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        self.plusButton = plusButton;
        
        [plusButton addTarget:self action:@selector(plusButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (NSMutableArray *)buttonArray {

    if (_buttonArray == nil) {
        _buttonArray = @[].mutableCopy;
    }
    return _buttonArray;
}


- (void)setTabBarItem:(UITabBarItem *)tabBarItem {

    _tabBarItem = tabBarItem;
    
    //获取到 title image
    //此函数调用一次创建一个Button
    WeiboTabBarButton *button = [WeiboTabBarButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    _tabBarItem = tabBarItem;
    button.tabBarItem = tabBarItem;
    
    [self addSubview:button];
    button.ratio = .67;
    
    //存储在全局按钮数组里面
    [self.buttonArray addObject:button];
    
    //当第一次调用这个方法 就让第一个按钮处于选中状态
    if (self.buttonArray.count == 1) {
        button.selected = YES;
        _selectedButton = button;
    }
    
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 40, 20, 10);
//    button.titleEdgeInsets = UIEdgeInsetsMake(20, -10, 0, 10);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //布局子视图 循环按钮数组 做相应的布局
    
    if (self.buttonArray.count == 0) {
        return;
    }
    CGFloat btnWidth = CGRectGetWidth(self.frame) / (CGFloat)(self.buttonArray.count + 1);
    CGFloat plusW = self.plusButton.currentBackgroundImage.size.width;
    CGFloat plusH = self.plusButton.currentBackgroundImage.size.height;
    self.plusButton.frame = CGRectMake(0, 0, plusW, plusH);
//    self.plusButton.center = self.center; //这样写button 会在下面
    
    self.plusButton.center = CGPointMake(CGRectGetWidth(self.frame) * 0.5, CGRectGetHeight(self.frame) * 0.5);
    
    
    
    for (int i = 0; i < self.buttonArray.count; i++) {
    
        WeiboTabBarButton *btn = self.buttonArray[i];
        CGFloat buttonX = btnWidth * i;
        if (i >= 2) {
            buttonX += btnWidth;
        }
        CGFloat buttonY = 0;
        CGFloat buttonW = btnWidth;
        CGFloat buttonH = CGRectGetHeight(self.frame);
        
        btn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
}

#pragma mark - Action

- (void)buttonPressed:(WeiboTabBarButton *)sender {
    
//  //1.循环
//    for (WeiboTabBarButton *button in self.buttonArray) {
//        button.selected = NO;
//    }
//    sender.selected = YES;
    //2.记录
    _selectedButton.selected = NO;
    sender.selected = YES;
    _selectedButton = sender;
    
    NSInteger index = [_buttonArray indexOfObject:sender];
//    //响应代理的方法
//    if ([_delegate respondsToSelector:@selector(passIndex:)]) {
//        [_delegate passIndex: index];
//    }
    
    //响应Block的方法
    if (_passBlock) {
        _passBlock(index);
    }
}

- (void)plusButtonPressed:(WeiboTabBarButton *)sender {

    if (_plusButtonBlock) {
        _plusButtonBlock(sender);
    }
}

@end
