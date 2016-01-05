//
//  OAuthTool.h
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OAuthModel;

@interface OAuthTool : NSObject 

//存档
+ (BOOL)saveOAuthInfoWithModel:(OAuthModel *)model;

//解档
+ (OAuthModel *)fetchOAuthModel;


@end
