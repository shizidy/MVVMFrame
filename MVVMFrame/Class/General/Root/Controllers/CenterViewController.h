//
//  CenterViewController.h
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CenterViewController : BaseViewController
@property (nonatomic, strong) HomeViewController *homeVC;
@end

NS_ASSUME_NONNULL_END
