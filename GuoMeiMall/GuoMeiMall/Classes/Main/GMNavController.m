//
//  GMNavController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMNavController.h"

@interface GMNavController ()

@end

@implementation GMNavController
+ (void)load{
    [self setupBase];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)setupBase{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = RGB(245, 245, 245);
    [bar setTintColor:[UIColor darkGrayColor]];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    UIColor *navColor = [UIColor blackColor];
    att[NSForegroundColorAttributeName] = navColor;
    att[NSFontAttributeName] = PFR18Font;
    bar.titleTextAttributes = att;
}
#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count >=1) {
        UIBarButtonItem *navItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        navItem.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItems = @[navItem,backButton];
        viewController.hidesBottomBarWhenPushed = YES;
        ///返回滑动功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}
#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
