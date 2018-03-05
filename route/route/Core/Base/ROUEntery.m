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
#import "ROUBlankViewController.h"
#import "ROUWebViewController.h"

@interface ROUEntery()

@property (nonatomic, strong) ROUBlankViewController *blankViewController;

@end

@implementation ROUEntery

+ (ROUEntery *)manager {
    static ROUEntery *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ROUEntery alloc] init];
    });
    return manager;
}

- (void)enteryURL:(NSString *)url {
    NSURL *enteryURL = [NSURL URLWithString:url];

    //检测url是否合法
    if (![self checkURLParameter:enteryURL]) {
        return ;
    }
    
    //url是否可以跳转web页面
    if ([self canOpenWebViewWithScheme:enteryURL.scheme]) {
        ROUWebViewController *webViewController = [[ROUWebViewController alloc] init];
        webViewController.url = enteryURL;
        [[ROUNavigator manager].rootViewController pushViewController:webViewController animated:YES];
        return ;
    }
    
    //检测自定义的url是否符合配置
    if (![self checkCustomURLParameter:enteryURL]) {
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
        } else {
            [[ROUNavigator manager].rootViewController pushViewController:self.blankViewController animated:YES];
        }
    } else {
        [[ROUNavigator manager].rootViewController pushViewController:self.blankViewController animated:YES];
    }
}

- (ROUBlankViewController *)blankViewController {
    if (!_blankViewController) {
        _blankViewController = [[ROUBlankViewController alloc] init];
    }
    return _blankViewController;
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


/**
 是否以push方式跳转到下一个vc
 默认push方式
 @return YES push方式
         NO present方式
 */
- (BOOL)presentToNextVCFromURLPath:(NSString *)path {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    if ([dic[@"data"][path][@"present"] isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)dic[@"data"][path][@"present"]).boolValue;
    } else {
        return dic[@"data"][path][@"present"];
    }
}

- (UIViewController *)getCurrentVCWithURL:(NSString *)url {
    NSURL *enteryURL = [NSURL URLWithString:url];
    
    if (![self checkURLParameter:enteryURL]) {
        return nil;
    }
    
    //url是否可以跳转web页面
    if ([self canOpenWebViewWithScheme:enteryURL.scheme]) {
        ROUWebViewController *webViewController = [[ROUWebViewController alloc] init];
        webViewController.url = enteryURL;
        return webViewController;
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
            return obj;
        } else {
            return obj;
        }
#pragma clang diagnostic pop

    } else {
        return nil;
    }
}


/**
 根据scheme判断是否能跳转到webView

 @param scheme URL的scheme
 @return 是否可以打开webView
 */
- (BOOL)canOpenWebViewWithScheme:(NSString *)scheme {
    if (!scheme.length) {
        return NO;
    }
    NSArray *schemeList = @[@"http", @"https", @"ftp", @"mailto", @"file", @"data", @"irc"];
    return [schemeList containsObject:scheme];
}

@end
