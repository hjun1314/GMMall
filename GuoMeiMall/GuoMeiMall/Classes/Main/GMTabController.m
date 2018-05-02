//
//  GMTabController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMTabController.h"
#import "GMNavController.h"
#import "GMLoginController.h"
/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"
@interface GMTabController ()<UITabBarControllerDelegate>
@property (nonatomic,strong)NSMutableArray *tabItems;

@end

@implementation GMTabController
#pragma mark - LazyLoad
- (NSMutableArray *)tabBarItems {
    
    if (_tabItems == nil) {
        _tabItems = [NSMutableArray array];
    }
    
    return _tabItems;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self addChildVC];
    //默认选中商城
    self.selectedViewController = [self.viewControllers objectAtIndex:GMTabControllerHome];
}

- (void)addChildVC{
    NSArray *childArray = @[
                            @{MallClassKey  : @"GMBeautyMessageController",
                              MallTitleKey  : @"美信",
                              MallImgKey    : @"tabr_01_up",
                              MallSelImgKey : @"tabr_01_down"},
                            
                            @{MallClassKey  : @"GMHomeController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"tabr_02_up",
                              MallSelImgKey : @"tabr_02_down"},
                            
                            @{MallClassKey  : @"GMMediaListController",
                              MallTitleKey  : @"美媒榜",
                              MallImgKey    : @"tabr_03_up",
                              MallSelImgKey : @"tabr_03_down"},
                            
                            @{MallClassKey  : @"GMBeautyShopController",
                              MallTitleKey  : @"美店",
                              MallImgKey    : @"tabr_04_up",
                              MallSelImgKey : @"tabr_04_down"},
                            
                            @{MallClassKey  : @"GMMyCenterController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tabr_05_up",
                              MallSelImgKey : @"tabr_05_down"},
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(obj[MallClassKey])new];
        GMNavController *nav = [[GMNavController alloc]initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.image = [UIImage imageNamed:obj[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:obj[MallSelImgKey]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        [self addChildViewController:nav];
        // 添加tabBarItem至数组
        [self.tabItems addObject:vc.tabBarItem];
    }];
}
#pragma mark- tabbarDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (viewController == [tabBarController.viewControllers objectAtIndex:GMTabControllerPerson]) {
        ///判断是否登录状态
        if (![[DCObjManager dc_readUserDataForKey:@"isLogin"]isEqualToString:@"1"]) {
            GMLoginController *loginVC = [GMLoginController new];
            [self presentViewController:loginVC animated:YES completion:nil];
            return NO;
        }
        
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    [self tabbarButtonClick:[self getTabBarButton]];
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    for (UIView *tabbarButton in self.tabBar.subviews) {
        if ([tabbarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtons addObject:tabbarButton];
        }
    }
    UIControl *tabbarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    return tabbarButton;
}
#pragma mark- 点击动画
- (void)tabbarButtonClick:(UIControl *)tabbarButton{
    for (UIView *imageView in tabbarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            [imageView.layer addAnimation:animation forKey:nil];
    }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
