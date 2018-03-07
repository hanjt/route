//
//  ROUEntery.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ROUEntery : NSObject

+ (ROUEntery *)manager;

/**
 跳转到指定的vc

 @param url 入口地址
 */
- (void)openURL:(NSURL *)url;


/**
 获得将要跳转的vc

 @param url 入口地址
 @return 返回将要跳转的vc
 */
- (UIViewController *)getNextVCWithURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
