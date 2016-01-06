//
//  HomeTableViewController.m
//  CD1505Weibo
//
//  Created by HeHui on 15/12/29.
//  Copyright (c) 2015年 Hawie. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIBarButtonItem+Util.h"
#import "TitleButton.h"
#import "DropControl.h"
#import "AFHTTPSessionManager+Util.h"
#import "Homepage_API.h"
#import "OAuthTool.h"
#import "OAuthModel.h"
#import "OAuthViewController.h"
#import "StatusModel.h"
#import "WBFrameModel.h"
#import "WBCell.h"

@interface HomeTableViewController ()

/** 下拉框*/
@property (nonatomic,strong) DropControl *dropControl;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeTableViewController

- (NSMutableArray *)dataArray {
 
    if (_dataArray == nil) {
        _dataArray = @[].mutableCopy;
    }
    
    return _dataArray;
}

- (DropControl *)dropControl
{
    if (_dropControl == nil) {
        
        NSArray *dataArr = @[@"床前明月光",
                             @"地上鞋两双",
                             @"举头望明月",
                             @"低头思故乡"];
        
        _dropControl = [[DropControl alloc] initWithInsideViewFrame:CGRectMake(100, 60, 180, 300) inView:self.tabBarController.view dataSource:dataArr];
        _dropControl.backgroundColor = [UIColor clearColor];
        
        __weak typeof(self) weakSelf = self;
        _dropControl.afhBlk = ^ {
          
            // 隐藏之后的回调代码
            TitleButton *btn = (TitleButton *)weakSelf.navigationItem.titleView;
            if (btn.selected) {
                btn.selected = NO;
            }
        };
        
        _dropControl.dsBlk = ^ (NSInteger index) {
            // 隐藏之后的回调代码
            TitleButton *btn = (TitleButton *)weakSelf.navigationItem.titleView;
            if (btn.selected) {
                btn.selected = NO;
            }

            NSLog(@"index = %ld",index);
        };
    }
    return _dropControl;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNaviBarItem];
/**/
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/** 构建导航栏 */
- (void)createNaviBarItem
{
 
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormaImageName:@"navigationbar_friendattention" highlightedImageName:@"navigationbar_friendattention_highlighted" target:self selector:@selector(leftBarButtonItemPressed)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormaImageName:@"navigationbar_icon_radar" highlightedImageName:@"navigationbar_icon_radar_highlighted" target:self selector:@selector(rightBarButtonItemPressed)];
    
    TitleButton *btn = [TitleButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"大王叫我来巡山" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    btn.frame = CGRectMake(0, 0, 200, 30);
    btn.backgroundColor =[UIColor clearColor];
    
    self.navigationItem.titleView = btn;
    
    [btn addTarget:self action:@selector(titleBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - title按钮点击
- (void)titleBtnPressed:(TitleButton *)btn
{
    btn.selected = !btn.selected;
  
    
    if (btn.selected) {
        [self.dropControl show];
    
    }else {
        [self.dropControl dismiss];
    }
    
    
}

#pragma mark - 导航栏按钮点击
/** 导航栏左边按钮点击*/
- (void)leftBarButtonItemPressed
{
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%u",arc4random()%200];
}

/** 导航栏右边按钮点击*/
- (void)rightBarButtonItemPressed
{
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}


#pragma mark - Data request

- (void)requestData {
    
    NSMutableDictionary *paramas = @{}.mutableCopy;
    //获取存储下来的用户信息（授权token）
    OAuthModel  *model = [OAuthTool fetchOAuthModel];
    if (model == nil) {
        self.view.window.rootViewController = [[OAuthViewController alloc] init];
    } else {
        paramas[@"access_token"] = model.access_token;
        paramas[@"count"] = @200;
    }
    
    [AFHTTPSessionManager requestWithType: AFHTTPSessionManagerRequestTypeGET URLString:WB_API_HOME_TIMELINE  parmaeters:paramas success:^(NSURLSessionDataTask *task, id responseObject) {

        NSArray *statusArr = responseObject[@"statuses"];
        NSArray *sModelArr = [StatusModel mj_objectArrayWithKeyValuesArray:statusArr];
        
        //循环数据model 创建FrameModel
        for (StatusModel *sModel in sModelArr) {
            WBFrameModel *fModel = [[WBFrameModel alloc] init];
            fModel.statusModel = sModel;
            
            //
            [self.dataArray addObject:fModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
     
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - <UITableViewDelegate & UITableViewDataSource>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    //取出frameModel
    WBFrameModel *frameModel = self.dataArray[indexPath.row];
    
    return frameModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *cellID = @"Cell";
    
    WBCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[WBCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    WBFrameModel *model = self.dataArray[indexPath.row];
    cell.framModel = model;
    
    return cell;
}

@end
