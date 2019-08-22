//
//  ROURouter.h
//  route
//
//  Created by hanjiatong on 2018/3/5.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROURouter : NSObject

+ (ROURouter *)manager;

/**
 跳转到指定的vc
 
 @param url 入口地址
 */
- (UIViewController *)openURL:(NSURL *)url;

/**
 跳转到指定的vc

 @param url 入口地址
 @param response 回调，不指定数据格式，建议用json进行数据传递
 */
- (UIViewController *)openURL:(NSURL *)url resopnseBlock:(id)response;

@end
