//
//  GMAppVersion.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMAppVersion.h"

@implementation GMAppVersion
+ (NSString *)GM_GetLastOneAppVersion{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AppVersion"];
}
/**
 *  保存新版本
 */
+ (void)GM_SaveNewAppVersion:(NSString *)version{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"AppVersion"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
