//
//  GMCenterServiceCell.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMGoodsGridModel;
@interface GMCenterServiceCell : UITableViewCell

@property (nonatomic,strong)NSMutableArray<GMGoodsGridModel *> *goodsGridArray;


@end
