//
//  GMAppVersion.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMAppVersion : NSObject

/**
*  获取之前保存的版本
*
*  @return NSString类型的AppVersion
*/
+ (NSString *)GM_GetLastOneAppVersion;
/**
 *  保存新版本
 */
+ (void)GM_SaveNewAppVersion:(NSString *)version;

@end
