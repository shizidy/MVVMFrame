//
//  RootViewController.m
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "RootViewController.h"
#define kMargin 80
#define kScreenHeight     [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth       [[UIScreen mainScreen] bounds].size.width
@interface RootViewController () <UIAlertViewDelegate> {
    BOOL isLeftMenuShow;
    BOOL isRightMenuShow;
    CGPoint originPoint;
}
@property (nonatomic, assign)MenuStyle menuStyle;//菜单样式
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIView *coverView;//遮盖层
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@end
@implementation RootViewController

#pragma mark ========== init ==========
-(instancetype)initWithMenuStyle:(MenuStyle)style{
    if (self = [super init]) {
        self.menuStyle = style;
        originPoint = CGPointMake(0, 0);
        isLeftMenuShow = NO;
        isRightMenuShow = NO;
        self.statusBarStyle = UIStatusBarStyleLightContent;
        [self setNeedsStatusBarAppearanceUpdate];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建UI
    [self setUI];
    
    // Do any additional setup after loading the view.
}

#pragma mark ========== 状态栏颜色 ==========
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.statusBarStyle;
}
#pragma mark ========== 创建UI ==========
-(void)setUI {
    [self addChildViewController:self.leftVC];
    [self addChildViewController:self.rightVC];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.centerVC];
    [self addChildViewController:nav];
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.rightVC.view];
    [self.view addSubview:nav.view];
    [self.centerVC.view addSubview:self.coverView];
    self.coverView.hidden = YES;

    //添加拖动手势
    [self.view addGestureRecognizer:self.panGesture];
}
#pragma mark ========== 拖动手势事件 ==========
-(void)pan:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture translationInView:self.view];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        if (point.x + originPoint.x > kScreenWidth - kMargin) {
            originPoint = CGPointMake(kScreenWidth - kMargin, 0);
            self.centerVC.navigationController.view.transform = CGAffineTransformMakeTranslation(kScreenWidth - kMargin, 0);
        } else if (point.x + originPoint.x < 0) {
            originPoint = CGPointMake(0, 0);
            self.centerVC.navigationController.view.transform = CGAffineTransformIdentity;
        } else {
            self.centerVC.navigationController.view.transform = CGAffineTransformMakeTranslation(point.x + originPoint.x, 0);
        }
    }
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSLog(@"%.1f", point.x + originPoint.x);
        //左菜单关闭状态
        if (originPoint.x == 0 && self.menuStyle == LeftMenuStyle) {
            if (point.x >= kMargin && point.x < kScreenWidth - kMargin) {
                originPoint = CGPointMake(kScreenWidth - kMargin, 0);
                [UIView animateWithDuration:0.3 animations:^{
                    self.centerVC.navigationController.view.transform = CGAffineTransformMakeTranslation(kScreenWidth - kMargin, 0);
                }];
            }
            if (point.x < kMargin && point.x > 0) {
                originPoint = CGPointMake(0, 0);
                [UIView animateWithDuration:0.3 animations:^{
                    self.centerVC.navigationController.view.transform = CGAffineTransformIdentity;
                }];
            }
        }
        //左菜单开启状态
        if (originPoint.x == kScreenWidth - kMargin && self.menuStyle == LeftMenuStyle) {
            if (point.x > -kMargin && point.x < 0) {
                originPoint = CGPointMake(kScreenWidth - kMargin, 0);
                [UIView animateWithDuration:0.3 animations:^{
                    self.centerVC.navigationController.view.transform = CGAffineTransformMakeTranslation(kScreenWidth - kMargin, 0);
                }];
            }
            if (point.x <= -kMargin && point.x + originPoint.x > 0) {
                originPoint = CGPointMake(0, 0);
                [UIView animateWithDuration:0.3 animations:^{
                    self.centerVC.navigationController.view.transform = CGAffineTransformIdentity;
                }];
            }
        }
    }
}

#pragma mark ========== dealloc ==========
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ========== 懒加载 ==========
-(LeftViewController *)leftVC{
    if (_leftVC==nil) {
        _leftVC = [[LeftViewController alloc] init];
    }
    return _leftVC;
}
-(RightViewController *)rightVC{
    if (_rightVC==nil) {
        _rightVC = [[RightViewController alloc] init];
    }
    return _rightVC;
}
-(CenterViewController *)centerVC{
    if (_centerVC==nil) {
        _centerVC = [[CenterViewController alloc] init];
    }
    return _centerVC;
}
-(UIPanGestureRecognizer *)panGesture{
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    }
    return _panGesture;
}
-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.2;
        _coverView.userInteractionEnabled = YES;
    }
    return _coverView;
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
