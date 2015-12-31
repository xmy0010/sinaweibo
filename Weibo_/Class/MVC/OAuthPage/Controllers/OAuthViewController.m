//
//  OAuthViewController.m
//  Weibo_
//
//  Created by 千锋 on 15/12/31.
//  Copyright (c) 2015年 千锋. All rights reserved.
//

#import "OAuthViewController.h"
#import "Weibo_OAuthInfo.h"


@interface OAuthViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self generateWebPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateWebPage {
    //IntelliJ IDE
//    NSString *htmlStr = @"<!DOCTYPE html> <html> <p>timeMechine</p> </html>";
//    [self.webView loadHTMLString:htmlStr baseURL:nil];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",WB_API_REQUESTURL, WB_APPKEY, WB_REDIRECTURI];
    
    //创建请求授权的request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: urlString]] ;
    
    [self.webView loadRequest:request];
}


#pragma mark - <UIWebViewDelegate>

//此方法在跳转某个URL的时候调用  可用来监听webView的显示的url
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    //请求的url的字符串
//    NSLog(@"%@", request.URL.absoluteString);
    
    NSString *urlString = request.URL.absoluteString;
    if ([urlString containsString:@"code="] && [urlString containsString: WB_REDIRECTURI]) {
        NSArray *arr = [urlString componentsSeparatedByString:@"code="];
        NSString *code = [arr lastObject];
        
        //第一步 拿到code
        
        //第二步 。。。
        
        [self getAccesstokenWithCode:code];
        
        //如果是获取到授权code的页面  拿到code 页面不需要
        return NO;
    }
    return YES;
}

-(void)getAccesstokenWithCode:(NSString *)code {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  
    
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
