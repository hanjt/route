
//
//  ROUBaseViewController.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROUBaseViewController : UIViewController

@property (nonatomic, copy) NSString *url;

/**
 url中的query
 */
@property (nonatomic, copy) NSString *paramsJSON;

/**
 url解析后的参数
 */
@property (nonatomic, copy, readonly) NSDictionary *paramsDic;

@end
