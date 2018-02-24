//
//  ROUEntery.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROUEntery : NSObject

/**
 入口地址

 @param url 入口url
 @return 返回vc
 */
+ (UIViewController *)enteryURL:(NSString *)url;

@end
