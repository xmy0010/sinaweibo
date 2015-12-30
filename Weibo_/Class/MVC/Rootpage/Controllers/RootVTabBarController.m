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
#import <PopMenu.h>

@interface RootVTabBarController ()  {

}

@property (nonatomic, strong) WeiboTabBar *wbTabBar; //自定义tabbar
@property (nonatomic, strong) PopMenu *popMenu;

@end

@implementation RootVTabBarController

- (PopMenu *)popMenu {

    if (_popMenu == nil) {
        NSMutableArray *items = @[].mutableCopy;
      
        NSArray *titles = @[@"文字",
                            @"相册",
                            @"微博",
                            @"签到",
                            @"点评",
                            @"更多"];
        NSArray *imageNames = @[@"tabbar_compose_idea",
                                @"tabbar_compose_photo",
                                @"tabbar_compose_weibo",
                                @"tabbar_compose_lbs",
                                @"tabbar_compose_review",
                                @"tabbar_compose_more"];
        for (int index; index < titles.count; index++) {
            MenuItem *item = [[MenuItem alloc] initWithTitle:titles[index] iconName:imageNames[index] glowColor:[UIColor magentaColor]];
            [items addObject:item];
        }
        
        _popMenu = [[PopMenu alloc] initWithFrame:[UIScreen mainScreen].bounds items:items];
        
        _popMenu.didSelectedItemCompletion = ^ (MenuItem *selectedItem) {
        
            NSLog(@"点了%@", selectedItem.title);
        };
    }
    
    return _popMenu;
}

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
//    self.wbTabBar.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    self.wbTabBar.passBlock = ^(NSInteger index){
        weakSelf.selectedIndex = index;
    };
    
    self.wbTabBar.plusButtonBlock = ^(WeiboTabBarButton *sender) {
    
        //显示弹出界面
        [weakSelf.popMenu showMenuAtView:weakSelf.view];
    };
    
    
    [self.view addSubview:self.wbTabBar];
    
    //通过图片取出corlor
    self.wbTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
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
//    //高亮
//    NSArray *hlImageArray = @[@"tabbar_home_highlighted",
//                               @"tabbar_message_center_highlighted",
//                               @"tabbar_discover_highlighted",
//                               @"tabbar_profile_highlighted"];
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

#pragma mark - <WeiboTabBarDelegate>

- (void)passIndex:(NSInteger)index {

    self.selectedIndex = index;
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
