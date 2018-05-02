//
//  GMUserAddressCell.h
//  GuoMeiMall
//
//  Created by hjun on 2018/5/2.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMAddressItem;
@interface GMUserAddressCell : UITableViewCell

@property (nonatomic,strong)GMAddressItem *addressItem;
/***删除按钮回调***/
@property (nonatomic,copy)dispatch_block_t deleteBtnBlock;
/***编辑按钮回调***/
@property (nonatomic,copy)dispatch_block_t editBtnBlock;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
/***默认选中按钮回调***/
@property (nonatomic,copy)void (^selectDefauleBtn)(BOOL isSelect);






@end
