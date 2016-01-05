//
//  OAuthTool.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "OAuthTool.h"
#import "OAuthModel.h"

#define ArchivePath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"OAuth.data"]

@implementation OAuthTool

+ (BOOL)saveOAuthInfoWithModel:(OAuthModel *)model {

//    NSString *archivePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    //NSHomeDirectory() + /Documents
//    NSString *path = [NSString stringWithFormat:@"%@/%@", archivePath,@"OAuth.data"];

    
    //app/xxxxx/documents/OAuth.data

    
    return [NSKeyedArchiver archiveRootObject:model toFile: ArchivePath];
}

+ (OAuthModel *)fetchOAuthModel {

    //如果已经过期 返回空或抛出异常
    NSDate *now = [NSDate date];
    OAuthModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:ArchivePath];
    
    if ([now compare:model.expiresDate] == NSOrderedAscending) {
        //没过期才return
        return model;
    } else {
        return nil;
    }
}

@end
