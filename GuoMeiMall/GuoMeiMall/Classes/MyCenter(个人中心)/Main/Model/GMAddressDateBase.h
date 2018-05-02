//
//  GMAddressDateBase.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GMAddressItem;
@interface GMAddressDateBase : NSObject
///地址数据
@property (nonatomic,strong)GMAddressItem *addressItem;

///dataBase数据
+ (instancetype)sharedDataBase;

/***新增地址**/
- (void)addNewAddress:(GMAddressItem *)address;

/***删除地址***/
- (void)deleteAddress:(GMAddressItem *)address;

/***更新地址***/
- (void)updateAddress:(GMAddressItem *)adress;

/***获取所有数据***/
- (NSMutableArray *)getAllAddressData;

@end
