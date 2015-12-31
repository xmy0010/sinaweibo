//
//  DropControl.m
//  Weibo_
//
//  Created by 千锋 on 15/12/30.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "DropControl.h"

//点击何处 drop消失
typedef NS_ENUM(NSInteger, HideDropType) {
        HideDropTypeOutside,
        HideDropTypeFromInside
};

static CGFloat rowHeight = 25;
static NSString *dropCellID = @"DropCellID";

@interface DropControl () < UITableViewDelegate, UITableViewDataSource>

//weak
@property (nonatomic, weak) UIView *obj_superView;
@property (nonatomic, strong) UIImageView *dropImageView;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;


@end

@implementation DropControl

- (instancetype)initWithInsideViewFrame:(CGRect)frame inView:(UIView *)view dataSource:(NSArray *)dataArray{

    if (self = [super init]) {
        self.obj_superView = view;
        //这个是自身的frame 传进来的参数是子视图的frame 和父视图对象
        self.frame = [UIScreen mainScreen].bounds;
        //将传入的子视图的frame记录下来
        self.imageFrame = frame;
        
        //存储传入的数据源
        self.dataArray = [dataArray copy];
        
        self.backgroundColor = [UIColor clearColor];
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchDown];
        
        //初始化子视图
        self.dropImageView = [[UIImageView alloc] init];
        [self addSubview:self.dropImageView];
        
        //拉伸图片
        self.dropImageView.image = [[UIImage imageNamed:@"popover_background"] stretchableImageWithLeftCapWidth:5 topCapHeight:10];
//        self.dropImageView.contentMode = UIViewContentModeScaleToFill;这样很模糊
        
        CGRect tableRect = frame;
        tableRect.origin.x = 5;
        tableRect.origin.y = 10;
        tableRect.size.width -= 10;
        tableRect.size.height -= 20;
        self.dropImageView.userInteractionEnabled = YES;//可拦截下点击让tableView响应
        self.tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.dropImageView addSubview:_tableView];
        
        //设置一个中间变量 计算tableView需要的高度
        CGRect absluteRect = self.tableView.frame;
        //估算高度 如果估算高度超过了限制的最大高度 则让其就等于最大高度
        CGFloat tableHeight = self.dataArray.count * rowHeight > absluteRect.size.height ? absluteRect.size.height : self.dataArray.count * rowHeight;
        absluteRect.size.height = tableHeight;
        self.tableView.frame = absluteRect;
    }
    return self;
}

- (void)show {
    
    [self.obj_superView addSubview:self];
//    CGFloat height = self.imageFrame.size.height;
    //动画显示
    CGRect rect  = self.imageFrame;
    rect.size.height = 0;

    //先给一个初始位置 再用动画让其到应该的位置
    self.dropImageView.frame = rect;
 
    //设置一个中间变量 计算tableView需要的高度
    CGRect absluteRect = self.tableView.frame;
    CGFloat tableHeight = self.dataArray.count * rowHeight > absluteRect.size.height ? absluteRect.size.height : self.dataArray.count * rowHeight;
    rect.size.height = tableHeight + 25;
    
   

    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
     self.dropImageView.frame = rect;
    } completion:nil];
    self.userInteractionEnabled = YES;
}

- (void)dismiss {

    [self removeFromSuperview];
}

- (void)hide {
    
    [self hideWithType:HideDropTypeOutside withIndexPath:-1];
}

- (void)hideWithType:(HideDropType)type withIndexPath:(NSInteger)index {

    CGRect rect = self.imageFrame;
    rect.size.height = 0;
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    
        self.dropImageView.frame = rect;
    } completion:^(BOOL finished){
        
        [self dismiss];
        
        switch (type) {
            case HideDropTypeOutside: {
                if (_dismissCompletion) {
                    _dismissCompletion();
                }
            }
                break;
            case HideDropTypeFromInside: {
                if (_didselectedIndexBlock) {
                    _didselectedIndexBlock(index);
                }
                if (_dismissCompletion) {
                    _dismissCompletion();
                }
                
            }
                break;
            default:
                break;
        }
        
    }];
    self.userInteractionEnabled = YES;
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return rowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dropCellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dropCellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    return cell;
}

#pragma warning --

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //反选 --    
    [self hideWithType:HideDropTypeFromInside withIndexPath:indexPath.row];
    

}

@end
