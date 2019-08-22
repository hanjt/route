//
//  DetailViewController.m
//  route
//
//  Created by hanjiatong on 2018/2/22.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "DetailViewController.h"
#import "ROUEntery.h"
#import "Configuration.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)presentOnClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/present", projectScheme, projectHost]]];
}

- (IBAction)pushOnClick:(UIButton *)sender {
    NSString *url = @"http%3a%2f%2fwww.peyesight.cn%2fmedial1%2findex.html%3fsmt_cp%3d110442%26smt_pl%3d2806189%26smt_md%3d4410";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/webview?url=%@", projectScheme, projectHost, url]]];
}

- (IBAction)callbackTipOnClick:(UIButton *)sender {
    [[ROUEntery manager] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/present", projectScheme, projectHost]] resopnseBlock:^(id response){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"路由回调" message:[NSString stringWithFormat:@"%@", response] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
