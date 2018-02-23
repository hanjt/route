//
//  ROUEntery.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ROUEntery.h"
#import "Configuration.h"

@implementation ROUEntery

+ (UIViewController *)enteryURL:(NSString *)url {
    NSAssert(url.length, @"url can not be nil");
    if (!url.length) {
        return nil;
    }
    NSURL *enteryURL = [NSURL URLWithString:url];

    NSAssert(enteryURL.scheme.length, @"url scheme can not be nil");
    if (!enteryURL.scheme.length) {
        return nil;
    }
    
    NSAssert(projectScheme.length, @"project scheme can not be nil");
    if (![enteryURL.scheme isEqualToString:projectScheme]) {
        return nil;
    }
    
    NSAssert(projectHost.length, @"project host can not be nil");
    if (![enteryURL.host isEqualToString:projectHost]) {
        return nil;
    }
    
    NSAssert(enteryURL.host.length, @"url host can not be nil");
    if (!enteryURL.host.length) {
        return nil;
    }
    
    NSAssert(enteryURL.path.length, @"url path can not be nil");
    if (!enteryURL.path.length) {
        return nil;
    }
    
    NSString *VCName =  [self getVCNameFromURLPath:enteryURL.path];
    NSAssert(VCName.length, @"vc name is invalid");
    if (!VCName.length) {
        return nil;
    }
    
    Class class = NSClassFromString(VCName);
    NSAssert(class, @"vc is not exist");
    if (class) {
        id obj = [[class alloc] init];
        if ([class instancesRespondToSelector:@selector(setParamsJSON:)]) {
            [obj performSelector:@selector(setParamsJSON:) withObject:enteryURL.query];
            return obj;
        } else {
            return obj;
        }
    } else {
        return nil;
    }
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
    return dic[path];
}

@end
