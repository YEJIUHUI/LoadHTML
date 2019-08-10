//
//  ViewController.m
//  LoadHtml
//
//  Created by jacob on 8/6/19.
//  Copyright © 2019 ye. All rights reserved.
//

#import "ViewController.h"
#import "MyWKWebView.h"
@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) MyWKWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //创建网页视图
    self.webView = [[MyWKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"校视通用户手册及隐私政策" ofType:@"html"];
    
    [self.webView loadLocalHTML:path color:nil bgcolor:nil font:300];
}

@end
