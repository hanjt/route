//
//  ROUEntery.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROUEntery : NSObject

+ (ROUEntery *)manager;

/**
 跳转到指定的vc

 @param url 入口地址
 */
- (void)enteryURL:(NSString *)url;


/**
 根据url获得指定vc
 用于- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;中，用于解耦

 @param url 入口地址
 @return 指定vc
 */
- (UIViewController *)getCurrentVCWithURL:(NSString *)url;

@end
