//
//  RootVTabBarController.m
//  Weibo_
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "RootVTabBarController.h"
#import "HomeTableViewController.h"
#import "DisscoveryTableViewController.h"
#import "MessageTableViewController.h"
#import "PersonalTableViewController.h"
#import "WeiboTabBar.h"

@interface RootVTabBarController () {

}

@property (nonatomic, strong) WeiboTabBar *wbTabBar; //自定义tabbar

@end

@implementation RootVTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    //添加自定义tabbar
    [self addCustomTabBar];
    //添加viewcontrollers
    [self addViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addCustomTabBar {
    self.tabBar.hidden = YES;
    
    self.wbTabBar = [[WeiboTabBar alloc] initWithFrame:CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49)];
    [self.view addSubview:self.wbTabBar];
    self.wbTabBar.backgroundColor = [UIColor orangeColor];
}

- (void)addViewControllers {

    
    NSArray *VCnames = @[@"HomeTableViewController",
                         @"MessageTableViewController",
                         @"DisscoveryTableViewController",
                         @"PersonalTableViewController"];
    NSArray *VCtitles = @[@"首页",
                          @"消息",
                          @"发现",
                          @"我"];
    //普通
    NSArray *norImageArray = @[@"tabbar_home",
                               @"tabbar_message_center",
                               @"tabbar_discover",
                               @"tabbar_profile"];
    //高亮
    NSArray *hlImageArray = @[@"tabbar_home_highlighted",
                               @"tabbar_message_center_highlighted",
                               @"tabbar_discover_highlighted",
                               @"tabbar_profile_highlighted"];
    //选中
    NSArray *selImageArray = @[@"tabbar_home_selected",
                              @"tabbar_message_center_selected",
                              @"tabbar_discover_selected",
                              @"tabbar_profile_selected"];
    
    for (NSString *VCname in VCnames) {
        Class vcClass = NSClassFromString(VCname);
        NSInteger index = [VCnames indexOfObject:VCname];
        
        UITableViewController *VC = [[vcClass alloc] init];
        VC.title = VCtitles[index];
        VC.tabBarItem.image = [[UIImage imageNamed: norImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        VC.tabBarItem.selectedImage = [[UIImage imageNamed: selImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //修改文字颜色
         NSDictionary *norAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor lightGrayColor]};
         NSDictionary *selAttribute = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor orangeColor]};
        
        [VC.tabBarItem setTitleTextAttributes:norAttribute forState:UIControlStateNormal];
        [VC.tabBarItem setTitleTextAttributes:selAttribute forState:UIControlStateSelected];
        
        UINavigationController *navigationC = [[UINavigationController alloc] initWithRootViewController:VC];
        
        [self addChildViewController:navigationC];
        
        self.wbTabBar.tabBarItem = VC.tabBarItem;
    }
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
