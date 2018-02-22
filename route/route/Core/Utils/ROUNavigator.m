//
//  ROUNavigator.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ROUNavigator.h"

@implementation ROUNavigator

+ (ROUNavigator *)manager {
    static ROUNavigator *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[ROUNavigator alloc] init];
    });
    return model;
}
    
- (UIViewController *)getTopViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    return keyWindow.rootViewController;
}

@end
