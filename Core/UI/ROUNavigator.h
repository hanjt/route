//
//  ROUNavigator.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ROUNavigator : NSObject

+ (ROUNavigator *)manager;

/**
 得到根控制器

 @return 返回根控制器
 */
- (UINavigationController *)rootViewController;

@end
