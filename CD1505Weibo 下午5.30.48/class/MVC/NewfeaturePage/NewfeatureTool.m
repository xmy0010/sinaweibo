//
//  NewfeatureTool.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "NewfeatureTool.h"
#import "NewfeatureViewController.h"
#import "RootTabBarController.h"
#import "AppDelegate.h"

@implementation NewfeatureTool

+ (void)choseRootViewController {

    //获取当前版本号
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = infoDict[@"CFBundleShortVersionString"];
    
    //获取存储下来的版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [userDefaults objectForKey:@"LastVersion"];
    
    //获取AppDelegate对象
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    //用当前版本号和存储的版本号对比
    if ([currentVersion compare:lastVersion] == NSOrderedDescending) {
        //降序表示有新版本, 将存储下来的版本号替换成最新版本
        [userDefaults setObject:currentVersion forKey:@"LastVersion"];
        [userDefaults synchronize];//同步到磁盘
        
        //加载引导页
        NewfeatureViewController *newfeatureVC = [[NewfeatureViewController alloc] init];
      
        appDelegate.window.rootViewController = newfeatureVC;
        
    } else {
    
        //加载主页
        RootTabBarController *rootVC = [[RootTabBarController alloc] init];
        appDelegate.window.rootViewController = rootVC;
    }

}

@end
