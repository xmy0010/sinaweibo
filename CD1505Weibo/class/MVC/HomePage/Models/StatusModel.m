//
//  StatusModel.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "StatusModel.h"


@implementation StatusModel

//说明pic_urls里面装Pic_urlsModels对象
+ (NSDictionary *)mj_objectClassInArray {

    return @{@"pic_urls" : @"Pic_urlsModel"};
}


@end
