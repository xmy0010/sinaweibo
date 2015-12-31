//
//  NewFeatureViewController.m
//  Weibo_
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "RootVTabBarController.h"

#define IMAGE_NUMBER 4

@interface NewFeatureViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createNewFeatureImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNewFeatureImages {

    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_scrollView];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * IMAGE_NUMBER, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    for (int i = 0; i < IMAGE_NUMBER; i++) {
        NSString *imageName = [NSString stringWithFormat:@"newfeature%02d", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
        
        if (i == IMAGE_NUMBER - 1) {
            imageView.userInteractionEnabled = YES;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"new_feature_button"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"new_feature_button_highlighted"] forState:UIControlStateHighlighted];
            CGSize size = [button.currentBackgroundImage size];
            button.frame = CGRectMake(0, 0, size.width, size.height);
            button.center = CGPointMake(CGRectGetWidth(imageView.frame) * 0.5, CGRectGetHeight(imageView.frame) * 0.5 + 100);
            [imageView addSubview:button];
            [button addTarget:self action:@selector(showRoot:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

//--隐藏状态栏
- (BOOL)prefersStatusBarHidden {

    return YES;
}

#warning here ...
//显示主页面
- (void)showRoot:(UIButton *)sender {

    RootVTabBarController *rootTabBarC = [[RootVTabBarController alloc] init];
    //截屏
    UIView *shotView = [self.view snapshotViewAfterScreenUpdates:YES];
    self.view.window.rootViewController = rootTabBarC;
    //截屏添加到Root上
    [rootTabBarC.view addSubview:shotView];
    
    [UIView animateWithDuration:1.6 animations:^{
        shotView.transform = CGAffineTransformScale(shotView.transform, 1.5, 1.5);
        
      //  shotView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        
        shotView.alpha = 0;
    } completion:^(BOOL finished) {
        [shotView removeFromSuperview];
       
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
