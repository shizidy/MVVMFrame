//
//  BaseViewController.m
//  MVVMFrame
//
//  Created by Macmini on 2019/8/21.
//  Copyright © 2019 Macmini. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseViewModel.h"

@interface BaseViewController ()
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) BaseViewModel *viewModel;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    BaseViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController);
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController);
        [viewController bindViewModel];
        [viewController loadData];
        [viewController configSubViews];
        [viewController setTitleView];
        [viewController registViewModelProtocol];
    }];
    return viewController;
}
#pragma mark -
- (BaseViewController *)initWithViewModel:(id)viewModel {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (instancetype)initWithParams:(NSDictionary *)params {
    if (self = [super init]) {
        self.params = params;
        self.viewModel = [self mapViewModelWithParams:params];
    }
    return self;
}

- (void)configSubViews {};

- (void)bindViewModel {};

- (void)loadData {};

- (void)setTitleView {}
#pragma mark -
- (BaseViewModel *)mapViewModelWithParams:(NSDictionary *)params {
    // view到viewModel的映射
    NSString *viewClassString = NSStringFromClass([self class]);
    NSString *viewModel = [viewClassString stringByReplacingOccurrencesOfString:@"Controller" withString:@"Model"];
    BaseViewModel *resultViewModel = [[NSClassFromString(viewModel) alloc] initWithParams:params];
    if (![resultViewModel isKindOfClass:[BaseViewModel class]]) {
        NSLog(NSLocalizedString(@"未匹配到对应viewModel--->%@", nil),[resultViewModel class]);
        return nil;
    }
    return resultViewModel;
}


#pragma mark ========== 实现协议方法 ==========
- (void)registViewModelProtocol {
    @weakify(self);
    [[self.viewModel rac_signalForSelector:@selector(pushViewModel:animated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UIViewController *viewController = (UIViewController *)[self mapViewControllerForViewModel:tuple.first];
        [self.navigationController pushViewController:viewController animated:[tuple.second boolValue]];
    }];
    
    [[self.viewModel rac_signalForSelector:@selector(popViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[self.viewModel rac_signalForSelector:@selector(popToRootViewModelAnimated:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.navigationController popToRootViewControllerAnimated:[tuple.first boolValue]];
    }];
    
    [[self.viewModel rac_signalForSelector:@selector(presentViewModel:animated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        UIViewController *viewController = (UIViewController *)[self mapViewControllerForViewModel:tuple.first];
        
//        if (![viewController isKindOfClass:UINavigationController.class]) {
//            viewController = [[BaseNavigationViewController alloc] initWithRootViewController:viewController];
//        }
        
        [self presentViewController:viewController animated:[tuple.second boolValue] completion:tuple.third];
    }];
    
    [[self.viewModel rac_signalForSelector:@selector(dismissViewModelAnimated:completion:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self dismissViewControllerAnimated:[tuple.first boolValue] completion:tuple.second];
    }];
    
//    [[self.viewModel rac_signalForSelector:@selector(showHudMessage:)] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self);
//        ShowMessageInView(self.view, tuple.first);
//    }];
//    [[self.viewModel rac_signalForSelector:@selector(showHudSuccess:)] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self);
//        ShowSuccessInView(self.view, tuple.first);
//    }];
//    [[self.viewModel rac_signalForSelector:@selector(showHudError:)] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self);
//        ShowErrorInView(self.view, tuple.first);
//    }];
//    [[self.viewModel rac_signalForSelector:@selector(showHint:)] subscribeNext:^(RACTuple *tuple) {
//        @strongify(self);
//        ShowHudInView(self.view, tuple.first);
//    }];
//    [[self.viewModel rac_signalForSelector:@selector(hideHud)] subscribeNext:^(id x) {
//        @strongify(self);
//        HideHudInView(self.view);
//    }];
}

- (UIViewController *)mapViewControllerForViewModel:(BaseViewModel *)viewModel {
    NSString *viewModelClassString = NSStringFromClass([viewModel class]);
    NSString *viewController = [viewModelClassString stringByReplacingOccurrencesOfString:@"Model" withString:@"Controller"];
    UIViewController *resultViewController = [[NSClassFromString(viewController) alloc] initWithViewModel:viewModel];
    if (![resultViewController isKindOfClass:[BaseViewController class]] && [resultViewController isKindOfClass:[UITableViewController class]]) {
        NSLog(NSLocalizedString(@"未匹配到对应viewModel--->%@", nil),[resultViewController class]);
        return nil;
    }
    return resultViewController;
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
