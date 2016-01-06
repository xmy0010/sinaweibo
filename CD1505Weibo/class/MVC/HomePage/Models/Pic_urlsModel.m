//
//  Pic_urlsModel.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "Pic_urlsModel.h"

@implementation Pic_urlsModel

- (void)setThumbnail_pic:(NSString *)thumbnail_pic {

    _thumbnail_pic = thumbnail_pic;
    
    //将大图片的地址存下来
    NSString *largePic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
    self.large_pic = largePic;
}

@end
