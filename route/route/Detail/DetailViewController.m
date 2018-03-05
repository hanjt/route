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
    [[ROUEntery manager] openURL:[NSString stringWithFormat:@"%@://%@/present", projectScheme, projectHost] completion:nil];
}

- (IBAction)pushOnClick:(UIButton *)sender {
    [[ROUEntery manager] openURL:[NSString stringWithFormat:@"%@://%@/push", projectScheme, projectHost] completion:nil];
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
