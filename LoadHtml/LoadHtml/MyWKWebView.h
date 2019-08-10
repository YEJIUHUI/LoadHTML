//
//  MyWKWebView.h
//  WebExtend
//
//  Created by Mr Qian on 2017/10/22.
//  Copyright © 2017年 Mr Qian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface MyWKWebView : UIView<WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) NSString *color;//网页前景色
@property (strong, nonatomic) NSString *bgcolor;//网页背景色
@property (nonatomic) int font;//网页字体大小


//加载本地内容
- (void)loadLocalHTML:(NSString*)path color:(NSString*)color bgcolor:(NSString*)bgcolor font:(int)font;

//加载网页内容
- (void)loadHTML:(NSString*)content color:(NSString*)color bgcolor:(NSString*)bgcolor font:(int)font;

@end
