//
//  BaseViewControllerProtocol.h
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class BaseViewModel;
@protocol BaseViewControllerProtocol <NSObject>
@optional

//Pass to your own ViewModel
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;
// init viewModel with params
- (instancetype)initWithParams:(NSDictionary *)params;

- (void)bindViewModel;

- (void)loadData;

- (void)configSubViews;
@end

NS_ASSUME_NONNULL_END
