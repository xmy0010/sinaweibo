//
//  AFHTTPSessionManager+Util.h
//  Weibo_
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, AFHTTPSessionManagerRequestType) {
     AFHTTPSessionManagerRequestTypeGet,
     AFHTTPSessionManagerRequestTypePost
};

@interface AFHTTPSessionManager (Util)


- (void)requestWithType:(AFHTTPSessionManagerRequestType)type URLString:(NSString)urlString parameters:(id)parameters success:(void(^)(NSURLSessionDataTask, id))success failure:(void(^)(NSURLSessionDataTask , NSError)) failure;

@end
