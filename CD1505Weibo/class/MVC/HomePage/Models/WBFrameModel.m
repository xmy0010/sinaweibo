//
//  WBFrameModel.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "WBFrameModel.h"
#import "PicBackgroundView.h"

CGFloat const vWidth_Height = 15;

@implementation WBFrameModel

- (void)setStatusModel:(StatusModel *)statusModel {
 
    UserModel *userModel = statusModel.user;
    
    
    //第一块
    //顶部背景图层
    CGFloat topOriginX = 0;
    CGFloat topOriginY = 0;
    CGFloat topWidth = SCREEN_WIDTH;
    CGFloat topHeight = 0; // 暂时设为0
    
    //1.用户头像
    CGFloat userIconX = WB_Spacing_Normal;
    CGFloat userIconY = WB_Spacing_Normal;
    CGFloat userIconWidth_Height = 50;
    self.userIconImageViewFrame = CGRectMake(userIconX, userIconY, userIconWidth_Height, userIconWidth_Height);
    
    //2.是否是验证用户的图标
    CGFloat userVerifyWidth_Height = vWidth_Height;
    CGFloat userVerifyX_Y = userIconWidth_Height - userVerifyWidth_Height;
    
    if (userModel.verified) {
        
    } else {
        userVerifyWidth_Height = 0;
    }
    self.userVerifyImageViewFrame = CGRectMake(userVerifyX_Y, userVerifyX_Y, userVerifyWidth_Height, userVerifyWidth_Height);
    
   
    //3.用户名
    CGFloat usernameX = CGRectGetMaxX(_userIconImageViewFrame) + WB_Spacing_Normal;
    CGFloat usernameY = CGRectGetMinY(_userIconImageViewFrame);
    CGSize usernameSize = [userModel.name sizeWithAttributes:@{NSFontAttributeName : WB_Font_Username}];
    self.usernameLableFrame = (CGRect) {{usernameX, usernameY}, usernameSize};
    
    //用户vip等级图标
    CGFloat userVipX = CGRectGetMaxX(_usernameLableFrame) + WB_Spacing_Small;
    CGFloat userVipY = usernameY;
    CGFloat userVipWidth_Height = vWidth_Height;
    if (userModel.mbrank > 0) {
        
    } else {
        userVipWidth_Height = 0;
    }
    self.userVipLevelImageViewFrame = CGRectMake(userVipX, userVipY, userVipWidth_Height, userVipWidth_Height);
    
    //微博发布时间
    CGFloat wbCTimeX = usernameX;
    CGFloat wbCTimeY = CGRectGetMaxY(_usernameLableFrame) + WB_Spacing_Small;
                                    //...
    CGSize wbCTimeSize = [statusModel.created_at sizeWithAttributes:@{NSFontAttributeName : WB_Font_Time}];
    self.wbCreateTimeLableFrame = (CGRect) {{wbCTimeX, wbCTimeY},wbCTimeSize};
   
    //来源
    CGFloat wbSourceX = CGRectGetMaxX(_wbCreateTimeLableFrame) + WB_Spacing_Small;
    CGFloat wbSourceY = wbCTimeY;
    CGSize wbSourceSize = [statusModel.source sizeWithAttributes:@{NSFontAttributeName : WB_Font_Time}];
    self.wbSourceLableFrame = (CGRect) {{wbSourceX, wbCTimeY}, wbSourceSize};
    
    topHeight =  MAX(CGRectGetMaxY(_userIconImageViewFrame), CGRectGetMaxY(_wbCreateTimeLableFrame)) + WB_Spacing_Normal;
    self.topBackgroundViewFrame = CGRectMake(topOriginX, topOriginY, topWidth, topHeight);
    
    //第二块
    //用户自己发布的微博内容背景图层
    CGFloat secondOriginX = topOriginX;
    CGFloat secondOriginY = CGRectGetMaxY(_topBackgroundViewFrame);
    CGFloat secondWidth = topWidth;
    CGFloat secondHeight = 0; //暂时
    
    //微博文字内容
    CGFloat wbContentX = userIconX;
    CGFloat wbContentY = 0;
    CGSize wbContentSize = [statusModel.text boundingRectWithSize:CGSizeMake(secondWidth - 2 * wbContentX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : WB_Font_Time} context:nil].size;
    self.wbContentLableFrame = (CGRect) {{wbContentX, wbContentY}, wbContentSize};
    //微博图片内容的背景图层
    CGFloat wbPicX = 0;
    CGFloat wbPicY = CGRectGetMaxY(_wbContentLableFrame) + WB_Spacing_Normal;
    CGFloat wbPicWidth = secondWidth;
    CGFloat wbPicHeight = [PicBackgroundView heightWithNumber:statusModel.pic_urls.count];
    self.wbPicsBackgroundViewFrame = CGRectMake(wbPicX, wbPicY, wbPicWidth, wbPicHeight);
    
    secondHeight = CGRectGetMaxY(_wbPicsBackgroundViewFrame);
    self.secondBackgroundViewFrame = CGRectMake(secondOriginX, secondOriginY, secondWidth, secondHeight);
    
    //第三块
//    //用户转发微博内容的背景图层
//    @property (nonatomic, assign) CGRect rwBackgroundViewFrame;
//    //转发微博的文字内容
//    @property (nonatomic, assign) CGRect rwWBContentLableFrame;
//    @property (nonatomic, assign) CGRect rwWBPicsBackgroundViewFrame;
//    
//    //第四块
//    //底部操作栏图层
//    @property (nonatomic, assign) CGRect bottomBackgroundFrame;
//    //1.转发按钮
//    @property (nonatomic, assign) CGRect repostButtonFrame;
//    //2.评论
//    @property (nonatomic, assign) CGRect commentButtonFrame;
//    //3.点赞
//    @property (nonatomic, assign) CGRect attitudeButtonFrame;
    

    
}

@end
