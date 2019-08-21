//
//  CenterViewController.m
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import "CenterViewController.h"
#import "HomeViewController.h"
#define kScreenHeight     [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth       [[UIScreen mainScreen] bounds].size.width
@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}

- (void)configSubViews {
    UIButton  *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2 - 100/2, kScreenHeight/2 - 50/2, 100, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClik:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClik:(UIButton *)btn {
    HomeViewController *viewController = [[HomeViewController alloc] initWithParams:@{}];
    [self.navigationController pushViewController:viewController animated:YES];
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
