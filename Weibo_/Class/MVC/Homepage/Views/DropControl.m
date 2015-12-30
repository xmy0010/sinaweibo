//
//  DropControl.m
//  Weibo_
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "DropControl.h"

@interface DropControl ()

//weak
@property (nonatomic, weak) UIView *obj_superView;


@end

@implementation DropControl

- (instancetype)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)view {

    if (self = [super init]) {
        self.obj_superView = view;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor redColor];
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)show {
    
    [self.obj_superView addSubview:self];
    
}

- (void)dismiss {

    [self removeFromSuperview];
}

@end
