//
//  UIBarButtonItem+Util.h
//  Weibo_
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Util)

//传入 图片名称来创建barButtontItem

+ (instancetype)generateBarButtonItemWithNormalImageName: (NSString *)norImageName highlightedImageName:(NSString *)hlimageName target:(id)target selector:(SEL)sel;

@end
