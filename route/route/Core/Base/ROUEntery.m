//
//  ROUEntery.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ROUEntery.h"
#import "Configuration.h"
#import "ROUNavigator.h"

@implementation ROUEntery

+ (void)enteryURL:(NSString *)url {
    NSURL *enteryURL = [NSURL URLWithString:url];

    if (![self checkURLParameter:enteryURL]) {
        return ;
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
            if ([self presentToNextVCFromURLPath:enteryURL.path]) {
                [[ROUNavigator manager].rootViewController presentViewController:obj animated:YES completion:nil];
            } else {
                [[ROUNavigator manager].rootViewController pushViewController:obj animated:YES];
            }
        }
    }
}

+ (BOOL)checkURLParameter:(NSURL *)URL {
    NSAssert(URL, @"url can not be nil");
    if (!URL) {
        return NO;
    }
    
    NSAssert(URL.scheme.length, @"url scheme can not be nil");
    if (!URL.scheme.length) {
        return NO;
    }
    
    NSAssert(projectScheme.length, @"project scheme can not be nil");
    if (![URL.scheme isEqualToString:projectScheme]) {
        return NO;
    }
    
    NSAssert(projectHost.length, @"project host can not be nil");
    if (![URL.host isEqualToString:projectHost]) {
        return NO;
    }
    
    NSAssert(URL.host.length, @"url host can not be nil");
    if (!URL.host.length) {
        return NO;
    }
    
    NSAssert(URL.path.length, @"url path can not be nil");
    if (!URL.path.length) {
        return NO;
    }
    
    return YES;
}

/**
 从url的path得到对应的vc

 @param path url的path
 @return 对应的vc名字
 */
+ (NSString *)getVCNameFromURLPath:(NSString *)path {
    if (!path.length) {
        return @"";
    }
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic[@"data"][path][@"vc"];
}


/**
 是否以push方式跳转到下一个vc
 默认push方式
 @return YES push方式
         NO present方式
 */
+ (BOOL)presentToNextVCFromURLPath:(NSString *)path {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if ([dic[@"data"][path][@"present"] isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)dic[@"data"][path][@"present"]).boolValue;
    } else {
        return dic[@"data"][path][@"present"];
    }
}

+ (UIViewController *)getCurrentVCWithURL:(NSString *)url {
    NSURL *enteryURL = [NSURL URLWithString:url];
    
    if (![self checkURLParameter:enteryURL]) {
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
            return obj;
        } else {
            return obj;
        }
#pragma clang diagnostic pop

    } else {
        return nil;
    }
}

@end
