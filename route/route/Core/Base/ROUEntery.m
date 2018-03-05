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

- (void)enteryViewControllerWithURL:(NSString *)url completion:(void (^ __nullable)(void))completion {
    NSURL *enterURL = [NSURL URLWithString:url];
    //url是否可以跳转web页面
    if ([self canOpenWebViewWithScheme:enterURL.scheme]) {
        self.webViewController.url = enterURL;
        [[ROUNavigator manager].rootViewController pushViewController:self.webViewController animated:YES];
        return ;
    }
    
    UIViewController *vc = [[ROURouter manager] enteryURL:url];
    if (!vc) {
        [[ROUNavigator manager].rootViewController pushViewController:self.blankViewController animated:YES];
        return;
    } else {
        if ([self presentToNextVCFromURLPath:enterURL.path]) {
            [[ROUNavigator manager].rootViewController presentViewController:vc animated:YES completion:completion];
        } else {
            [[ROUNavigator manager].rootViewController pushViewController:vc animated:YES];
        }
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

- (UIViewController *)getNextVCWithURL:(NSString *)url {
    return [[ROURouter manager] enteryURL:url];
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
