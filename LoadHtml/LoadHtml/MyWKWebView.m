//
//  MyWKWebView.m
//  WebExtend
//
//  Created by Mr Qian on 2017/10/22.
//  Copyright © 2017年 Mr Qian. All rights reserved.
//

#import "MyWKWebView.h"

@implementation MyWKWebView

//加载网页内容
- (void)loadLocalHTML:(NSString*)path color:(NSString*)color bgcolor:(NSString*)bgcolor font:(int)font {
    self.color = color;
    self.bgcolor = bgcolor;
    self.font = font;
    if (!self.webView) {
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds];
        self.webView.navigationDelegate = self;
//        self.webView.scrollView.showsVerticalScrollIndicator = NO;
//        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        self.webView.scrollView.bounces = NO;
        [self addSubview:self.webView];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    }
    else {
        [self updateWebCSS];//更新网页样式
    }
}

//加载网页内容
- (void)loadHTML:(NSString*)content color:(NSString*)color bgcolor:(NSString*)bgcolor font:(int)font {
    self.color = color;
    self.bgcolor = bgcolor;
    self.font = font;
    if (!self.webView) {
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds];
        self.webView.navigationDelegate = self;
//        self.webView.scrollView.showsVerticalScrollIndicator = NO;
//        self.webView.scrollView.showsHorizontalScrollIndicator = NO;
        self.webView.scrollView.bounces = NO;
        [self addSubview:self.webView];
        [self.webView loadHTMLString:content baseURL:nil];
    } else {
        [self updateWebCSS];//更新网页样式
    }
}


//更新网页CSS样式
- (void)updateWebCSS {
#if 1
    //修改图片宽度 方式一
    NSString *S = [NSString stringWithFormat:@"\
                   var maxWidth = %f;\
                   var images = document.images;\
                   for(var i = 0; i < images.length; i++) {\
                   var img = images[i];\
                   if (img.width > maxWidth) {\
                   img.width = maxWidth;\
                   }\
                   }\
                   ",self.webView.bounds.size.width-20];
    [self.webView evaluateJavaScript:S completionHandler:^(id obj, NSError * _Nullable error) {
        if(error){NSLog(@"修改图片宽度出现的错误信息%@",error);}
    }];
#endif
    
    //修改图片宽度 方式二
#if 0
    NSString *S = [NSString stringWithFormat:@"\
                   var s = document.createElement('script');\
                   s.type = 'text/javascript';\
                   s.resize = function() {\
                   var maxWidth = '%f';\
                   var imgs = document.images;\
                   for(var k = 0; k < imgs.length; k++) {\
                   var img = imgs[k];\
                   if(img.width > maxWidth) {\
                   img.width = maxWidth;\
                   }\
                   }\
                   };\
                   document.head.appendChild(s);\
                   s.resize();\
                   ",webView.bounds.size.width-20];
    [self.webView evaluateJavaScript:S completionHandler:^(id obj, NSError * _Nullable error) {
        if(error){NSLog(@"修改图片宽度出现的错误信息%@",error);}
    }];
#endif
    
#if 0
    //修改网页字体颜色
    NSString *S2 = [NSString stringWithFormat:@"document.body.style.color='%@'", self.color];
    [self.webView evaluateJavaScript:S2 completionHandler:^(id obj, NSError * _Nullable error) {
        if(error){NSLog(@"修改网页字体颜色出现的错误信息%@",error);}
    }];
#endif
    
#if 0
    //修改网页背景色
    NSString *S3 = [NSString stringWithFormat:@"document.body.style.background='%@'", self.bgcolor];
    [self.webView evaluateJavaScript:S3 completionHandler:^(id obj, NSError * _Nullable error) {
        if(error){NSLog(@"修改网页背景色出现的错误信息%@",error);}
    }];
#endif
    
#if 1
    //修改网页里字体的大小(webkit的css样式是基于safari和chrome的浏览器才有效)
    NSString *S4 = [NSString stringWithFormat:@"document.body.style.webkitTextSizeAdjust= '%d%%'", self.font];
    [self.webView evaluateJavaScript:S4 completionHandler:^(id obj, NSError * _Nullable error) {
        if(error){NSLog(@"修改网页里字体的大小出现的错误信息%@",error);}
    }];
#endif
    
#if 1
    //动态获取webview的内容总高度
    [self.webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id obj, NSError * _Nullable error) {
        NSLog(@"webview的内容总高度=%f",((NSNumber*)obj).floatValue);
    }];
#endif
    
#if 1
    //禁止网页自带的复制，选中功能(webkit的css样式是基于safari和chrome的浏览器才有效)
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:^(id wid, NSError * _Nullable error) {
        if(error){NSLog(@"禁止网页自带的选中,出现的错误信息%@",error);}
    }];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id wid, NSError * _Nullable error) {
        if(error){NSLog(@"禁止网页自带的复制,出现的错误信息%@",error);}
    }];
#endif
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self updateWebCSS];//更新网页样式
}

@end
