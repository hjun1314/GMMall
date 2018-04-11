//
//  GMMyCenterTopView.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMMyCenterTopView : UIView
/*** 左边item
 */
@property (nonatomic,copy)dispatch_block_t leftItemClickBlock;
/***右边item*/
@property (nonatomic,copy)dispatch_block_t rightItemClickBlock;

@end
