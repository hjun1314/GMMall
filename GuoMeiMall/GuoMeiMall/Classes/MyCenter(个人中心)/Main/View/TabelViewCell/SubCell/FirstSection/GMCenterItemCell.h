//
//  GMCenterItemCell.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMStateItem;
@interface GMCenterItemCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray<GMStateItem *> *stateItem;

@end
