//
//  AppDelegate.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/8.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "AppDelegate.h"
#import "GMTabController.h"
#import "GMAppVersion.h"
#import "GMNewFeatureController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self setupRootVC];
    [self setupFixiOS11];
NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);

    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)setupRootVC{
    if ([BUNDLE_VERSION isEqualToString:[GMAppVersion GM_GetLastOneAppVersion]]) {
        self.window.rootViewController = [[GMTabController alloc]init];
    }else{
        [GMAppVersion GM_SaveNewAppVersion:BUNDLE_VERSION];
        GMNewFeatureController *featureVC = [[GMNewFeatureController alloc]init];
        [featureVC setUpFeatureAttribute:^(NSArray *__autoreleasing *imageArray, UIColor *__autoreleasing *selColor, BOOL *showSkip, BOOL *showPageCount) {
            *imageArray = @[@"guide1",@"guide2",@"guide3",@"guide4"];
            *showPageCount = YES;
            *showSkip = YES;
            
        }];
        self.window.rootViewController = featureVC;
    }
    
}
void uncaughtExceptionHandler(NSException *exception) {    DLog(@"错误原因: %@", exception);
}
#pragma mark- 适配iOS 11
- (void)setupFixiOS11{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
