//
//  RootViewController.h
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "BaseViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "CenterViewController.h"

typedef enum : NSUInteger {
    LeftMenuStyle,
    RightMenuStyle,
    LeftandRightMenuStyle,
} MenuStyle;

@interface RootViewController : BaseViewController
@property (nonatomic, strong)LeftViewController *leftVC;//左菜单
@property (nonatomic, strong)RightViewController *rightVC;//右菜单
@property (nonatomic, strong)CenterViewController *centerVC;//中间菜单
-(instancetype)initWithMenuStyle:(MenuStyle)style;
@end
