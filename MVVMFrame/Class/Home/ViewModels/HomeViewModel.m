//
//  HomeViewModel.m
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel

- (void)loadData:(id)input subscriber:(id<RACSubscriber>)subscriber {
    NSLog(@"loadData");
    [subscriber sendNext:nil];
    [subscriber sendCompleted];
}

@end
