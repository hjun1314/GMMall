//
//  GMBeautyShopTopView.h
//  GuoMeiMall
//
//  Created by hjun on 2018/5/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMBeautyShopTopView : UIView
/***左边item点击***/
@property (nonatomic,copy)dispatch_block_t openShopClickBlock;
/***右边item点击***/
@property (nonatomic,copy)dispatch_block_t messageClickBlock;
@property (nonatomic,strong)UIButton *openShopBtn;
@property (nonatomic,strong)UIButton *messageBtn;



@end
