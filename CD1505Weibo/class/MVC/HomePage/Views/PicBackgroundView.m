//
//  PicBackgroundView.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/5.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "PicBackgroundView.h"

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

    
}

@end
