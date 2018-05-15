//
//  GMStoresRecommendCell.h
//  GuoMeiMall
//
//  Created by hjun on 2018/5/15.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMBeautyShopModel;
@interface GMStoresRecommendCell : UICollectionViewCell
/***上架点击回调***/
@property (nonatomic,copy)dispatch_block_t shelvesBtnClickBlock;

@property (nonatomic,strong)GMBeautyShopModel *beautyShop;

@end
