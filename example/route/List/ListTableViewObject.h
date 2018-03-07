//
//  ListTableViewObject.h
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewObject : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int row;

@end
