//
//  GMNotificationName.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/10.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMNotificationName.h"

@implementation GMNotificationName
/** 登录成功选择控制器通知 */
NSString *const LOGINSELECTCENTERINDEX = @"LOGINSELECTCENTERINDEX";
/** 退出登录成功选择控制器通知 */
NSString *const LOGINOFFSELECTCENTERINDEX = @"LOGINOFFSELECTCENTERINDEX";

/** 添加购物车或者立即购买通知 */
NSString *const SELECTCARTORBUY = @"SELECTCARTORBUY";

/** 滚动到商品详情界面通知 */
NSString *const SCROLLTODETAILSPAGE = @"SCROLLTODETAILSPAGE";
/** 滚动到商品评论界面通知 */
NSString *const SCROLLTOCOMMENTSPAGE = @"SCROLLTOCOMMENTSPAGE";

/** 展现顶部自定义工具条View通知 */
NSString *const SHOWTOPTOOLVIEW = @"SHOWTOPTOOLVIEW";
/** 隐藏顶部自定义工具条View通知 */
NSString *const HIDETOPTOOLVIEW = @"HIDETOPTOOLVIEW";


/** 商品属性选择返回通知 */
NSString *const SHOPITEMSELECTBACK = @"SHOPITEMSELECTBACK";

/** 分享弹出通知 */
NSString *const SHAREALTERVIEW= @"SHAREALTERVIEW";

/** 美信消息Item改变通知 */
NSString *const MESSAGECOUNTCHANGE = @"MESSAGECOUNTCHANGE";
@end
