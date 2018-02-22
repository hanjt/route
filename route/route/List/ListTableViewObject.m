//
//  ListTableViewObject.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ListTableViewObject.h"
#import "ROUEntery.h"
#import "ROUNavigator.h"

@implementation ListTableViewObject

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld", indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [ROUEntery enteryURL:@"route://first/detail"];
    UIViewController *rootVC = [[ROUNavigator manager] getTopViewController];
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)rootVC pushViewController:viewController animated:YES];
    }
}

@end
