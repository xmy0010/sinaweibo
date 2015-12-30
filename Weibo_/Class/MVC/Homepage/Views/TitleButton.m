//
//  TitleButton.m
//  Weibo_
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleRatio = 0.6;
        //button的title默认是居中 不过用下面改了之后会居左
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.imageView.contentMode = UIViewContentModeLeft;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {

    CGFloat imageX = _titleRatio * CGRectGetWidth(contentRect) + 10;
    CGFloat imageY = 0;
    CGFloat imageW = (1 - _titleRatio) * CGRectGetWidth(contentRect) - 10;
    CGFloat imageH = CGRectGetHeight(contentRect);
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = CGRectGetWidth(contentRect) * _titleRatio;
    CGFloat titleH = CGRectGetHeight(contentRect);
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
