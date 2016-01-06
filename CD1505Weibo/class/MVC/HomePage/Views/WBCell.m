//
//  WBCell.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "WBCell.h"
#import "PicBackgroundView.h"
#import "WBFrameModel.h"
#import <UIImageView+WebCache.h>

@interface WBCell ()

//第一块
//顶部背景图层
@property (nonatomic, strong) UIView *topBackgroundView;
//用户头像
@property (nonatomic, strong) UIImageView *userIconImageView;
//是否是验证用户的图标
@property (nonatomic, strong) UIImageView *userVerifyImageView;
//用户名
@property (nonatomic, strong) UILabel *usernameLable;
//用户vip等级图标
@property (nonatomic, strong) UIImageView *userVipLevelImageView;
//微博发布时间
@property (nonatomic, strong) UILabel *wbCreateTimeLable;
//来源
@property (nonatomic, strong) UILabel *wbSourceLable;

//第二块
//用户自己发布的微博内容背景图层
@property (nonatomic, strong) UIView *secondBackgroundView;
//微博文字内容
@property (nonatomic, strong) UILabel *wbContentLable;
//微博图片内容的背景图层
@property (nonatomic, strong) PicBackgroundView *wbPicsBackgroundView;

//第三块
//用户转发微博内容的背景图层
@property (nonatomic, strong) UIView *rwBackgroundView;
//转发微博的文字内容
@property (nonatomic, strong) UILabel *rwWBContentLable;
//图片内容
@property (nonatomic, strong) PicBackgroundView *rwWBPicsBackgroundView;

//第四块
//底部操作栏图层
@property (nonatomic, strong) UIView *bottomBackground;
//1.转发按钮
@property (nonatomic, strong) UIButton *repostButton;
//2.评论
@property (nonatomic, strong) UIButton *commentButton;
//3.点赞
@property (nonatomic, strong) UIButton *attitudeButton;


@end


@implementation WBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化所有子控件 并设置一次性属性
        [self generateSubViews];
    }
    return self;
}

//初始化所有的子控件
- (void)generateSubViews {
    
    //一.顶部背景图层
    self.topBackgroundView = [[UIView alloc] init];
    [self.contentView addSubview:_topBackgroundView];
    
    //1.用户头像
    self.userIconImageView = [[UIImageView alloc] init];
    [self.topBackgroundView addSubview:_userIconImageView];
    
    //2.是否是验证用户
    self.userVerifyImageView = [[UIImageView alloc] init];
    [self.topBackgroundView addSubview:_userVerifyImageView];
    
    //3.用户名
    self.usernameLable = [[UILabel alloc] init];
    self.usernameLable.font = WB_Font_Username;
    [self.topBackgroundView addSubview:_usernameLable];
    
    //4.vip等级图标
    self.userVipLevelImageView = [[UIImageView alloc] init];
    [self.topBackgroundView addSubview:_userVipLevelImageView];
    
    //5.微博发布时间
    self.wbCreateTimeLable = [[UILabel alloc] init];
    self.wbCreateTimeLable.font = WB_Font_Time;
    [self.topBackgroundView addSubview:_wbCreateTimeLable];
    
    //6.微博来源
    self.wbSourceLable = [[UILabel alloc] init];
    self.wbSourceLable.font = WB_Font_Time;
    [self.topBackgroundView addSubview:_wbSourceLable];
    
   /*********************Time Mechine******************************/
    
    //第二块
    self.secondBackgroundView = [[UIView alloc] init];
    [self.contentView addSubview:_secondBackgroundView];
    
    //1.微博文字内容
    self.wbContentLable = [[UILabel alloc] init];
    self.wbContentLable.font = WB_Font_Username;
    self.wbContentLable.numberOfLines = 0;
    [self.secondBackgroundView addSubview:_wbContentLable];
    
    //2。微博图片内容
    self.wbPicsBackgroundView = [[PicBackgroundView alloc] init];
    [self.secondBackgroundView addSubview:_wbPicsBackgroundView];
    
    /*********************Time Mechine******************************/
    
    //第三块
    //背景
    self.rwBackgroundView = [[UIView alloc] init];
    self.rwBackgroundView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_rwBackgroundView];
    
    //文字
    self.rwWBContentLable = [[UILabel alloc] init];
    self.rwWBContentLable.font = WB_Font_Username;
    self.rwWBContentLable.numberOfLines = 0;
    [self.rwBackgroundView addSubview:_rwWBContentLable];
    
    //图片
    self.rwWBPicsBackgroundView = [[PicBackgroundView alloc] init];
    [self.rwBackgroundView addSubview:_rwWBPicsBackgroundView];
    
    //第四块
    self.bottomBackground = [[UIView alloc] init];
    [self.contentView addSubview:_bottomBackground];
    
    //转发按钮
    self.repostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBackground addSubview:_repostButton];
    
    //评论
    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBackground addSubview:_commentButton];
    
    //点赞
    self.attitudeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bottomBackground addSubview:_attitudeButton];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFramModel:(WBFrameModel *)framModel {
        _framModel = framModel;
    StatusModel *statusModel = _framModel.statusModel;
    //第一块
    self.topBackgroundView.frame = framModel.topBackgroundViewFrame;
//    self.topBackgroundView.backgroundColor = [UIColor redColor];
    //用户图像
    NSURL *userIconUrl = [NSURL URLWithString:statusModel.user.profile_image_url];
    [self.userIconImageView sd_setImageWithURL:userIconUrl placeholderImage:[UIImage imageNamed: @"avatar_default_big"]];
    self.userIconImageView.frame = framModel.userIconImageViewFrame;
    self.userIconImageView.layer.masksToBounds = YES;
    
    //验证用户图标
    BOOL isVerified = statusModel.user.verified;
    NSString *userVerifiedImageName = nil;
    if (isVerified == YES) {
        if (statusModel.user.verified_type > 1) {
            userVerifiedImageName = @"avatar_enterprise_vip";
        } else {
            userVerifiedImageName = @"avatar_vip";
        }
    }
    self.userVerifyImageView.image = [UIImage imageNamed: userVerifiedImageName];//企业
    self.userVerifyImageView.frame = framModel.userVerifyImageViewFrame;
    
    //用户名
    self.usernameLable.text = statusModel.user.name;
    self.usernameLable.frame = framModel.usernameLableFrame;
    
    //用户vip等级
    NSInteger vipLevel = statusModel.user.mbrank;
    NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%ld", vipLevel];
    self.userVipLevelImageView.image = [UIImage imageNamed: vipImageName];
    self.userVipLevelImageView.frame = framModel.userVipLevelImageViewFrame;
    
    //发布时间
    self.wbCreateTimeLable.text = statusModel.created_at;
    self.wbCreateTimeLable.frame = framModel.wbCreateTimeLableFrame;
    
    //来源
    self.wbSourceLable.text = statusModel.source;
    self.wbSourceLable.frame = framModel.wbSourceLableFrame;
    
    
    //第二块
    self.secondBackgroundView.frame = framModel.secondBackgroundViewFrame;
//    self.secondBackgroundView.backgroundColor = [UIColor yellowColor];
    
    //文字内容
    self.wbContentLable.text = statusModel.text;
    self.wbContentLable.frame = framModel.wbContentLableFrame;
    
    //图片内容
    [self.wbPicsBackgroundView showPicsWithArray:statusModel.pic_urls];
    self.wbPicsBackgroundView.frame = framModel.wbPicsBackgroundViewFrame;
    
    //第三块
    
    //背景
    self.rwBackgroundView.frame = framModel.rwBackgroundViewFrame;
//    self.rwBackgroundView.backgroundColor = [UIColor blueColor];
    
    //文字
    self.rwWBContentLable.text = statusModel.retweeted_status.text;
    self.rwWBContentLable.frame = framModel.rwWBContentLableFrame;
    
    //图片
    [self.rwWBPicsBackgroundView showPicsWithArray:statusModel.retweeted_status.pic_urls];
    self.rwWBPicsBackgroundView.frame = framModel.rwWBPicsBackgroundViewFrame;
    
    //第四块
    self.bottomBackground.frame = framModel.bottomBackgroundFrame;
    self.bottomBackground.backgroundColor = [UIColor greenColor];
    //三个按钮
    self.repostButton.frame = framModel.repostButtonFrame;
    self.commentButton.frame = framModel.commentButtonFrame;
    self.attitudeButton.frame = framModel.attitudeButtonFrame;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.userIconImageView.layer.cornerRadius = CGRectGetWidth(_userIconImageView.frame) * 0.5;
}

@end
