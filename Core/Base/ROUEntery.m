//
//  ROUEntery.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ROUEntery.h"
#import "ROURouter.h"
#import "ROUBlankViewController.h"
#import "ROUWebViewController.h"
#import "ROUNavigator.h"

@interface ROUEntery()

@property (nonatomic, strong) ROUBlankViewController *blankViewController;
@property (nonatomic, strong) ROUWebViewController *webViewController;

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

- (BOOL)openURL:(NSURL *)url {
    UIViewController *vc = [[ROURouter manager] openURL:url];
    return [self openViewController:vc url:url];
}

- (BOOL)openURL:(NSURL *)url resopnseBlock:(nonnull id)response {
    UIViewController *vc = [[ROURouter manager] openURL:url resopnseBlock:response];
    return [self openViewController:vc url:url];
}

- (BOOL)openViewController:(UIViewController *)viewController url:(NSURL *)url {
    if (!viewController) {
        [[ROUNavigator manager].rootViewController pushViewController:self.blankViewController animated:YES];
        return NO;
    } else {
        if ([self presentToNextVCFromURLPath:url.path]) {
            [[ROUNavigator manager].rootViewController presentViewController:viewController animated:YES completion:nil];
        } else {
            [[ROUNavigator manager].rootViewController pushViewController:viewController animated:YES];
        }
        return YES;
    }
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

- (UIViewController *)getNextVCWithURL:(NSURL *)url {
    return [[ROURouter manager] openURL:url];
}

#pragma mark set/get
- (ROUBlankViewController *)blankViewController {
    if (!_blankViewController) {
        _blankViewController = [[ROUBlankViewController alloc] init];
    }
    return _blankViewController;
}

- (ROUWebViewController *)webViewController {
    if (!_webViewController) {
        _webViewController = [[ROUWebViewController alloc] init];
    }
    return _webViewController;
}

@end
