//
//  ROURouter.h
//  route
//
//  Created by hanjiatong on 2018/3/5.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 进入的ViewController类型
 */
typedef NS_ENUM(NSInteger, ROUEnterViewControllerType) {
    ROUEnterViewControllerTypeBlank,        //空页面
    ROUEnterViewControllerTypeWebView,      //webView
    ROUEnterViewControllerTypeNormal        //正常页面
    
};

@interface ROURouter : NSObject

+ (ROURouter *)manager;

/**
 跳转到指定的vc
 
 @param url 入口地址
 */
- (UIViewController *)openURL:(NSString *)url;

@end
