//
//  GMAddressItem.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMAddressItem : NSObject
@property(nonatomic,strong) NSNumber *ID;

/* 用户名 */
@property (nonatomic, copy) NSString *userName;
/* 用户电话 */
@property (nonatomic, copy) NSString *userPhone;
/* 选择地址地址 */
@property (nonatomic, copy) NSString *chooseAdress;
/* 用户地址 */
@property (nonatomic, copy) NSString *userAdress;

/* 默认地址 1为正常 2为默认 */
@property (nonatomic, copy) NSString *isDefault;
/***cell高度***/
@property (nonatomic,assign)CGFloat cellHeight;


@end
