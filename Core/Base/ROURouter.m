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

- (UIViewController *)openURL:(NSURL *)url {
    //检测url是否合法
    if (![self checkURLParameter:url]) {
        return nil;
    }
    
    //检测自定义的url是否符合配置
    if (![self checkCustomURLParameter:url]) {
        return nil;
    }
    
    Class class = NSClassFromString([self getVCNameFromURLPath:url.path]);
    if (class) {
        id obj = [[class alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([class instancesRespondToSelector:@selector(setUrl:)]) {
            [obj performSelector:@selector(setUrl:) withObject:url];
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

- (UIViewController *)openURL:(NSURL *)url resopnseBlock:(id)response {
    //检测url是否合法
    if (![self checkURLParameter:url]) {
        return nil;
    }
    
    //检测自定义的url是否符合配置
    if (![self checkCustomURLParameter:url]) {
        return nil;
    }
    
    Class class = NSClassFromString([self getVCNameFromURLPath:url.path]);
    if (class) {
        id obj = [[class alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([class instancesRespondToSelector:@selector(setUrl:)]) {
            [obj performSelector:@selector(setUrl:) withObject:url];
        }
        if (response && [class instanceMethodForSelector:@selector(setResopnseBlock:)]) {
            [obj performSelector:@selector(setResopnseBlock:) withObject:response];
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
    if (!URL) {
        return NO;
    }
    
    if (!URL.scheme.length) {
        return NO;
    }
    
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
    if (![URL.scheme isEqualToString:projectScheme]) {
        return NO;
    }
    
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
