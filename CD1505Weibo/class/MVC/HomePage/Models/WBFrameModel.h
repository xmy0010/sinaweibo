//
//  WBFrameModel.h
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StatusModel.h"

@interface WBFrameModel : NSObject

//通过StatusModel提前计算出每个控件的frame
@property (nonatomic, strong) StatusModel *statusModel;

@property (nonatomic, assign) CGFloat cellHeight;

//第一块
//顶部背景图层
@property (nonatomic, assign) CGRect topBackgroundViewFrame;
//用户头像
@property (nonatomic, assign) CGRect userIconImageViewFrame;
//是否是验证用户的图标
@property (nonatomic, assign) CGRect userVerifyImageViewFrame;
//用户名
@property (nonatomic, assign) CGRect usernameLableFrame;
//用户vip等级图标
@property (nonatomic, assign) CGRect userVipLevelImageViewFrame;
//微博发布时间
@property (nonatomic, assign) CGRect wbCreateTimeLableFrame;
//来源
@property (nonatomic, assign) CGRect wbSourceLableFrame;

//第二块
//用户自己发布的微博内容背景图层
@property (nonatomic, assign) CGRect secondBackgroundViewFrame;
//微博文字内容
@property (nonatomic, assign) CGRect wbContentLableFrame;
//微博图片内容的背景图层
@property (nonatomic, assign) CGRect wbPicsBackgroundViewFrame;

//第三块
//用户转发微博内容的背景图层
@property (nonatomic, assign) CGRect rwBackgroundViewFrame;
//转发微博的文字内容
@property (nonatomic, assign) CGRect rwWBContentLableFrame;
@property (nonatomic, assign) CGRect rwWBPicsBackgroundViewFrame;

//第四块
//底部操作栏图层
@property (nonatomic, assign) CGRect bottomBackgroundFrame;
//1.转发按钮
@property (nonatomic, assign) CGRect repostButtonFrame;
//2.评论
@property (nonatomic, assign) CGRect commentButtonFrame;
//3.点赞
@property (nonatomic, assign) CGRect attitudeButtonFrame;

@end
