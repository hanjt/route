//
//  NSURL+Addition.m
//  route
//
//  Created by hanjiatong on 2018/2/24.
//  Copyright © 2018年 hanjiatong. All rights reserved.
//

#import "NSURL+Addition.h"

@implementation NSURL (Addition)

- (NSDictionary *)paramsDic {
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self.absoluteString];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSURLQueryItem *item in urlComponents.queryItems) {
        if (item.name.length > 0 && item.value) {
            dic[item.name] = item.value;
        }
    }
    return dic;
}
@end
