//
//  ROURouter.m
//  route
//
//  Created by hanjiatong on 2018/3/5.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ROURouter.h"
#import "Configuration.h"

@interface ROURouter()

@end

@implementation ROURouter

+ (ROURouter *)manager {
    static ROURouter *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ROURouter alloc] init];
    });
    return manager;
}

- (UIViewController *)enteryURL:(NSString *)url {
    NSURL *enteryURL = [NSURL URLWithString:url];
    
    //检测url是否合法
    if (![self checkURLParameter:enteryURL]) {
        return nil;
    }
    
    //检测自定义的url是否符合配置
    if (![self checkCustomURLParameter:enteryURL]) {
        return nil;
    }
    
    Class class = NSClassFromString([self getVCNameFromURLPath:enteryURL.path]);
    NSAssert(class, @"vc is not exist");
    if (class) {
        id obj = [[class alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([class instancesRespondToSelector:@selector(setUrl:)]) {
            [obj performSelector:@selector(setUrl:) withObject:enteryURL];
        }
#pragma clang diagnostic pop
        if ([obj isKindOfClass:[UIViewController class]]) {
            return obj;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (BOOL)checkURLParameter:(NSURL *)URL {
    NSAssert(URL, @"url can not be nil");
    if (!URL) {
        return NO;
    }
    
    NSAssert(URL.scheme.length, @"url scheme can not be nil");
    if (!URL.scheme.length) {
        return NO;
    }
    
    NSAssert(URL.host.length, @"url host can not be nil");
    if (!URL.host.length) {
        return NO;
    }
    
    return YES;
}


/**
 检测自定义的url合法性
 
 @param URL url
 @return 检测自定义的url合法性
 */
- (BOOL)checkCustomURLParameter:(NSURL *)URL {
    NSAssert(projectScheme.length, @"project scheme can not be nil");
    if (![URL.scheme isEqualToString:projectScheme]) {
        return NO;
    }
    
    NSAssert(projectHost.length, @"project host can not be nil");
    if (![URL.host isEqualToString:projectHost]) {
        return NO;
    }
    return YES;
}

/**
 从url的path得到对应的vc
 
 @param path url的path
 @return 对应的vc名字
 */
- (NSString *)getVCNameFromURLPath:(NSString *)path {
    if (!path.length) {
        return @"";
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic[@"data"][path][@"vc"];
}

@end
