//
//  GMBeautyShopModel.h
//  GuoMeiMall
//
//  Created by hjun on 2018/5/15.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMBeautyShopModel : NSObject
/* 图片 */
@property (nonatomic, copy) NSString *shopImageUrl;
/* 商品标题 */
@property (nonatomic, copy) NSString *shopTitle;
/* 商品佣金 */
@property (nonatomic, copy) NSString *shopCommission;
/* 商品金额 */
@property (nonatomic, copy) NSString *shopAmount;
@end
