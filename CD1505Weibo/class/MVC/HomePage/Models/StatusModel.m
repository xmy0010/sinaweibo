//
//  StatusModel.m
//  CD1505Weibo
//
//  Created by 千锋 on 16/1/4.
//  Copyright (c) 2016年 Hawie. All rights reserved.
//

#import "StatusModel.h"


@implementation StatusModel

//说明pic_urls里面装Pic_urlsModels对象
+ (NSDictionary *)mj_objectClassInArray {

    return @{@"pic_urls" : @"Pic_urlsModel"};
}

- (void)setCreated_at:(NSString *)created_at {
    NSLog(@"%@", created_at);
    //在这里将时间转为需要显示的时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    //星期 月份 日 时：分：秒 年
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"CN"];
    NSDate *ctDate = [dateFormatter dateFromString:created_at];
    NSLog(@"%@", ctDate);
    //对比当前时间
    NSDate *now = [NSDate date];
    //日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //获取俩个时间的差
    NSDateComponents *components = [calendar components:unit fromDate:ctDate toDate:now options:NSCalendarWrapComponents];
    
    //是否是今年
    if (components.year == 0) {
        //是今年
        if ([calendar isDateInToday:ctDate]) {
            //今天
            if (components.hour >= 1) {
                [dateFormatter setDateFormat:@"今天 HH时mm分ss秒"];
                
            } else {
                //一小时之内
                if (components.minute >= 1) {
                    [dateFormatter setDateFormat:@"mm分钟前"];
                } else {
                    //一分钟之内
                    if (components.second >= 10) {
                        [dateFormatter setDateFormat:@"ss秒前"];
                    } else {
                        //十秒钟之内
                        [dateFormatter setDateFormat:@"刚刚"];
                    }
                }
            }
        } else if ([calendar isDateInYesterday:ctDate]) {
            //昨天
            [dateFormatter setDateFormat:@"昨天 HH时mm分"];
        } else {
            [dateFormatter setDateFormat:@"MM月dd日"];
        }
        
    } else {
        //不是今年
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
       
    }
    _created_at = [dateFormatter stringFromDate:ctDate];
    
    
    /**优先级从上往下*/
    //如果是去年
    //今年
    //1.10之内 --刚刚
    //2.小于一分钟  --xx秒前
    //3.小于一小时  --xx分钟前
    //4.今天之内    --今天XX时xx分
    //5.昨天发的    --昨天xx时xx分
    //6.昨天之前    --xx月xx日
}

- (void)setSource:(NSString *)source {

    NSArray *arr = [source componentsSeparatedByString:@"</a>"];
    NSArray *arr2 = [arr.firstObject componentsSeparatedByString:@">"];
    _source = [@"来自:" stringByAppendingString: arr2.lastObject];
}


@end
