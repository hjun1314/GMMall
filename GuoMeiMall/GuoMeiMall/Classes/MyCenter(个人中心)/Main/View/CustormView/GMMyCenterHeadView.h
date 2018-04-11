//
//  GMMyCenterHeadView.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMMyCenterHeadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *BtnIcon;

/* 头像点击回调 */
@property (nonatomic, copy) dispatch_block_t headClickBlock;
/** 二维码点击回调 */
@property (nonatomic, copy) dispatch_block_t qrClickBlock;
/** 我的朋友点击回调 */
@property (nonatomic, copy) dispatch_block_t myFriendClickBlock;
/** 朋友圈点击回调 */
@property (nonatomic, copy) dispatch_block_t friendCircleClickBlock;

/** 查看会员点击 */
@property (nonatomic, copy) dispatch_block_t seePriceClickBlock;

@end
