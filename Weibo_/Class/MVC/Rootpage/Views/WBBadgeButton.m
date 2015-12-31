//
//  WBBadgeButton.m
//  Weibo_
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "WBBadgeButton.h"
#import "UIImage+Util.h"

@implementation WBBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置图片
        [self setBackgroundImage:[UIImage autoResizeWithImageName:@"main_badge"] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
        
        //设置字体相关
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}


- (void)setBadgeValue:(NSString *)badgeValue {

    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    if (badgeValue.integerValue == 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    if (badgeValue.integerValue > 99) {
        badgeValue = @"99+";
    }
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    CGRect rect = self.frame;
    CGSize imageSize = self.currentBackgroundImage.size;
    
    
    //计算文字占用的大小
    CGSize wSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]}];
    CGFloat width = wSize.width > imageSize.width ? wSize.width + 10: imageSize.width;
    rect.size.width = width;
    rect.origin.x = self.superview.frame.size.width - width;
    
    self.frame = rect;
}

@end
