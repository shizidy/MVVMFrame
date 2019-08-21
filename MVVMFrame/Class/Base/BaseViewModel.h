//
//  BaseViewModel.h
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "BaseViewModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MKTitleViewType) {
    /// System title view
    MKTitleViewTypeDefault,
    /// Double title view
    MKTitleViewTypeDoubleTitle,
    /// Loading title view
    MKTitleViewTypeLoadingTitle
};

@interface BaseViewModel : NSObject <BaseViewModelProtocol>

/**
 initial parameters
 */
@property (nonatomic, copy, readonly) NSDictionary *params;

/**
 title of viewController
 */
@property (nonatomic, copy) NSString *title;

/**
 subtitle of viewController when titleViewType is MKTitleViewTypeDoubleTitle
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 navigationBar's customView type
 */
@property (nonatomic, assign) MKTitleViewType titleViewType;

/**
 default is NO
 */
@property (nonatomic, assign) BOOL showActivityView;

@property (nonatomic, strong, readonly) RACCommand *loadDataCommand;
@property (nonatomic, strong, readonly) RACCommand *universalCommand;
@property (nonatomic, strong, readonly) RACSubject *callbackSubject;
@end
NS_ASSUME_NONNULL_END
