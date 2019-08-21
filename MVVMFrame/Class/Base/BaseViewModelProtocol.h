//
//  BaseViewModelProtocol.h
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseViewModel;

@protocol BaseViewModelProtocol <NSObject>

@optional

- (instancetype)initWithParams:(NSDictionary *)params;

- (void)tx_initialize;

- (void)loadData:(id)input subscriber:(id<RACSubscriber>)subscriber;

- (void)loadMoreData:(id)input subscriber:(id<RACSubscriber>)subscriber;
//pageIndex=0时上拉下拉可只调用该方法
- (void)requestData:(id)input subscriber:(id<RACSubscriber>)subscriber;

- (void)universalRACCommand:(id)input subscriber:(id<RACSubscriber>)subscriber;

- (void)pushViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelAnimated:(BOOL)animated;

- (void)presentViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated completion:(dispatch_block_t)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(dispatch_block_t)completion;

//HUD
- (void)showHudMessage:(NSString *)message;
- (void)showHudSuccess:(NSString *)message;
- (void)showHudError:(NSString *)message;
- (void)showHint:(NSString *)hintText;
- (void)hideHud;

@end

