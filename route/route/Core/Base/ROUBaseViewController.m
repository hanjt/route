//
//  ROUBaseViewController.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "ROUBaseViewController.h"

@interface ROUBaseViewController ()

@end

@implementation ROUBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)paramsDic {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [self.paramsJSON componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        if ([[elts lastObject] isKindOfClass:[NSString class]]) {
            //如果是string需要进行utf8解码
            [params setObject:[(NSString *)[elts lastObject] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding] forKey:[elts firstObject]];
        } else {
            [params setObject:[elts lastObject] forKey:[elts firstObject]];
        }
    }
    return params;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
