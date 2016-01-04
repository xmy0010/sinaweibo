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

    return [NSKeyedUnarchiver unarchiveObjectWithFile: ArchivePath];
}

@end
