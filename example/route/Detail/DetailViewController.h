//
//  DetailViewController.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//
//scheme://host/detail?id=xxx

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) void (^resopnseBlock)(id response);

@end
