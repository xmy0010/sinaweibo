//
//  PicBackgroundView.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "PicBackgroundView.h"
#import "Pic_urlsModel.h"
#import <UIImageView+WebCache.h>
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface PicBackgroundView ()

@property (nonatomic, strong) MJPhotoBrowser *browser;
@property (nonatomic, strong) NSMutableArray *picsArr;

@end

@implementation PicBackgroundView

+(CGFloat)heightWithNumber:(NSInteger)number {

    CGFloat height = 0;
    if (number == 1) {
        CGFloat picWidth = (SCREEN_WIDTH - 2 * WB_Spacing_Normal) / 2.;
        height = picWidth + WB_Spacing_Normal;
    } else {
    
        CGFloat picWidth = (SCREEN_WIDTH - 4 * WB_Spacing_Normal) / 3.;
        CGFloat spaceNumber = 0;
        if (number % 3 == 0) {
            spaceNumber = number / 3;
        } else {
            spaceNumber = number / 3 + 1;
        }
        height = (picWidth + WB_Spacing_Normal) * spaceNumber;
    }
    
    return height;
}

- (void)showPicsWithArray:(NSArray *)array {
    _browser = nil;
     NSMutableArray *pbArr = @[].mutableCopy;
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    if (self.picsArr == nil) {
        self.picsArr = @[].mutableCopy;
    }
       [self.picsArr removeAllObjects];
    
    if (array.count == 0) {
        return;
    }
    
    if (array.count == 1) {
        Pic_urlsModel *model = array[0];
        CGFloat picWidth = (SCREEN_WIDTH - 2 * WB_Spacing_Normal) * 0.5;
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(WB_Spacing_Normal, 0, picWidth, picWidth)];
        [self addSubview:image];
        [image sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic]];
    } else {
       
        
        CGFloat picWidth = (SCREEN_WIDTH - 4 * WB_Spacing_Normal) / 3;
        for (int i = 0; i < array.count; i++) {
            Pic_urlsModel *model = array[i];
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic]];
            CGFloat imageX = (picWidth + WB_Spacing_Normal) * (i % 3);
            CGFloat imageY = (picWidth + WB_Spacing_Normal) * (i / 3);
            imageView.frame = CGRectMake(imageX, imageY, picWidth, picWidth);
            
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showLarge:)]];
            
            //创建一个大图对象
            MJPhoto *photo = [[MJPhoto alloc] init];
            //设置连接地址
            photo.url = [NSURL URLWithString:model.large_pic];
            //指定来源的imageView
            photo.srcImageView = imageView;
            
            [pbArr addObject:photo];
        }
        
        //创建图片浏览器
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.photos = pbArr.copy;
        self.browser = browser;
//        [browser show];
    }
    
}

#pragma mark - Action
- (void)showLarge:(UITapGestureRecognizer *)sender {
    
    [self.browser show];
    
}

@end
