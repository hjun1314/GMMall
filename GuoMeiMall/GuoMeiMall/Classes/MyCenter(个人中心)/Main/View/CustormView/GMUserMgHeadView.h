//
//  GMUserMgHeadView.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMUserMgHeadView : UIView
/** 头部点击回调 */
@property (nonatomic,copy)dispatch_block_t headButtonClickBlock;

/** 头部View点击回调 */
@property (nonatomic, copy) dispatch_block_t headViewTouchBlock;

/** 二维码点击回调 */
@property (nonatomic, copy) dispatch_block_t erCodeClickBlock;

/** 我的主页点击回调 */
@property (nonatomic, copy) dispatch_block_t myHomeClickBlock;

@end
