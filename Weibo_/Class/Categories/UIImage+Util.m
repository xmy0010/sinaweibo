//
//  UIImage+Util.m
//  Weibo_
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "UIImage+Util.h"

@implementation UIImage (Util)

//获取一张可以自动拉伸的图片
+ (UIImage *)autoResizeWithImageName:(NSString *)imageName {

    //1.创建一个图片
    UIImage *image = [UIImage imageNamed:imageName];
    //让图片可以自动拉伸
    CGSize imageSize = image.size;
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:imageSize.height * 0.5];
    
    return image;
}

@end
