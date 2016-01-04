//
//  OAuthModel.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "OAuthModel.h"

@implementation OAuthModel

//在存储过期时间差值的时候 存储下过期时间点
- (void)setExpires_in:(NSString *)expires_in {
    
   _expires_in = expires_in;
    
    //1.获取当前时间
    NSDate *nowDate = [NSDate date];
    
    //2.通过时间差值获取过期时间点
    NSDate *expiresDate = [nowDate dateByAddingTimeInterval:expires_in.doubleValue];

    //3.存储下过期的时间点
    self.expiresDate = expiresDate;
    
}

//归档 将对象的信息通过某种编码方式存储起来
- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expiresDate forKey:@"expiresDate"];
}

//解档 将获取到的归档信息通过某种编码方式解析出来
- (id)initWithCoder:(NSCoder *)aDecoder {

    self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
    self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
    self.remind_in = [aDecoder decodeObjectForKey:@"remind_in"];
    self.uid = [aDecoder decodeObjectForKey:@"uid"];
    self.expiresDate = [aDecoder decodeObjectForKey:@"expiresDate"];
    
    return self;
}

@end
