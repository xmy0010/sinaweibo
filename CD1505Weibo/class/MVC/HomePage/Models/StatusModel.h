//
//  StatusModel.h
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "Pic_urlsModel.h"
#import <MJExtension.h>

@interface StatusModel : NSObject

//发布时间
@property (nonatomic, copy) NSString *created_at;

//微博ID
@property (nonatomic, copy) NSString *idstr;

//微博文字的内容
@property (nonatomic, copy) NSString *text;

//来源
@property (nonatomic, copy) NSString *source;

//微博图片内容
@property (nonatomic, strong)NSArray *pic_urls;


//微博发布的用户
@property (nonatomic, strong) UserModel *user;

//转发数
@property (nonatomic, assign) long long reposts_count;

//评论数
@property (nonatomic, assign) long long comments_count;

//点赞数
@property (nonatomic, assign) long long attitudes_count;

//转发的微博
@property (nonatomic, strong) StatusModel *retweeted_status;

@end
