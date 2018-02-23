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
    
- (UINavigationController *)rootViewController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if ([keyWindow.rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)keyWindow.rootViewController;
    }
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:keyWindow.rootViewController];
    return nav;
}

@end
