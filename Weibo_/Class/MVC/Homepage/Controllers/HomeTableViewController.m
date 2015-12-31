//
//  HomeTableViewController.m
//  Weibo_
//
//  Created by 千锋 on 15/12/29.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "HomeTableViewController.h"
#import "UIBarButtonItem+Util.h"
#import "TitleButton.h"
#import "DropControl.h"

@interface HomeTableViewController ()

//下拉框
@property (nonatomic, strong) DropControl *dropControl;

@end

@implementation HomeTableViewController

- (DropControl *)dropControl {

    if (_dropControl == nil) {
        
        NSArray *dataArray = @[@"This",
                               @"gay",
                               @"heHas",
                               @"timeMechine",
                               @"sketch"];
        
        _dropControl = [[DropControl alloc] initWithInsideViewFrame:CGRectMake(100, 60, 180, 300) inView:self.tabBarController.view dataSource:dataArray];
        
        __weak typeof(self) weakSelf = self;
        _dropControl.dismissCompletion = ^{
        
            //隐藏之后回调的
            TitleButton *button = (TitleButton *)weakSelf.navigationItem.titleView;
            if (button.selected == YES) {
                button.selected = NO;
            }
        };
        
        _dropControl.didselectedIndexBlock = ^(NSInteger index){
            //code here...
            NSLog(@"%ld", index);
        };
    }
    
    return _dropControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createNaviBarItem];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//定制导航栏
- (void)createNaviBarItem {
    
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setImage:[UIImage imageNamed:@"navigationbar_friendattention"] forState:UIControlStateNormal];
//    [leftButton setImage:[UIImage imageNamed:@"navigationbar_friendattention_highlighted"] forState:UIControlStateHighlighted];
//    CGSize imageSize = leftButton.currentImage.size;
//    leftButton.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
//    
////    self.navigationItem.leftBarButtonItem = leftButton;不能这样写
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //类别写创建方法 更好的封装性
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormalImageName:@"navigationbar_friendattention" highlightedImageName:@"navigationbar_friendattention_highlighted" target:self selector:@selector(leftBarButtonItemPressed:)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem generateBarButtonItemWithNormalImageName:@"navigationbar_icon_radar" highlightedImageName:@"navigationbar_icon_radar_highlighted" target:self selector:@selector(rightBarButtonItemPressed:)];
    
    
    TitleButton *titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [titleButton setTitle:@"sinaBIG_V" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.frame = CGRectMake(0, 0, 200, 30);
    
    self.navigationItem.titleView = titleButton;
    
    
    [titleButton addTarget:self action:@selector(titleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)titleButtonPressed:(TitleButton *)sender {

    sender.selected = !sender.selected;
    
    //弹出一个view
    if (sender.selected) {
        
        [self.dropControl show];
    } else {
    
        [self.dropControl dismiss];
    }
   
    
    
}

- (void)leftBarButtonItemPressed:(UIBarButtonItem *)sender{

    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%u", arc4random() % 1000];
    
}

- (void)rightBarButtonItemPressed:(UIBarButtonItem *)sender {

    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
