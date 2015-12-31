//
//  WeiboTabBarButton.m
//  Weibo_
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "WeiboTabBarButton.h"
#import "WBBadgeButton.h"

@interface WeiboTabBarButton ()

//角标
@property (nonatomic, strong) WBBadgeButton *badgeButton;

@end

@implementation WeiboTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _ratio = 0.6;//设置一个默认值
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
//        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        //初始化badge
        self.badgeButton = [[WBBadgeButton alloc] init];
        [self addSubview:_badgeButton];
    }
    return self;
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {

    _tabBarItem = tabBarItem;
    
    //将自己添加成观察者 监听 _tabBarItem的角标值
    [_tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
    [self setTitleColor:[UIColor lightGrayColor] forState: UIControlStateNormal];
    [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    
    [self setTitle:tabBarItem.title forState:UIControlStateNormal];
    [self setImage:tabBarItem.image forState:UIControlStateNormal];
    [self setImage:tabBarItem.selectedImage forState:UIControlStateSelected];

    
}

- (void)setRatio:(CGFloat)ratio {

    if (ratio < 0 || ratio > 1) {
        NSException *exception = [[NSException alloc] initWithName:@"异常提示" reason:@"参数范围应为0~1" userInfo:nil];
        @throw exception;
    } else {
        _ratio = ratio;
    }
}

//生成按钮内部图片的位置(frame) contentRect为按钮自身的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
//    static int i = 0;
//    NSLog(@"%d", ++i);
    
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = CGRectGetWidth(contentRect);
    CGFloat imageH = CGRectGetHeight(contentRect) * self.ratio;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

//生成按钮内部titleLable的位置(frame)
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    static int i = 0;
    NSLog(@"%d", ++i);
    
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetHeight(contentRect) * _ratio;
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleH = CGRectGetHeight(contentRect) * (1 - self.ratio);
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

//拦截高亮状态响应 
- (void)setHighlighted:(BOOL)highlighted {

}

//布局子视图
- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGSize size = self.badgeButton.currentBackgroundImage.size;
    
    self.badgeButton.frame = CGRectMake(CGRectGetWidth(self.frame) - size.width, 0, size.width, size.height);
    self.badgeButton.badgeValue = _tabBarItem.badgeValue;

}

#pragma mark -KVO相关
-(void)dealloc {

    [_tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    self.badgeButton.badgeValue = _tabBarItem.badgeValue;
}

@end
