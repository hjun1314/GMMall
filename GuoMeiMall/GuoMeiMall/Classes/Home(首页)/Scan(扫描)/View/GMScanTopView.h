//
//  GMScanTopView.h
//  GuoMeiMall
//
//  Created by hjun on 2018/5/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMScanTopView : UIView
/***左边返回按钮***/
@property (nonatomic,copy)dispatch_block_t backItemClickBlock;
/***中间相册按钮***/
@property (nonatomic,copy)dispatch_block_t pickItemClickBlock;
/***右边手电筒按钮***/
@property (nonatomic,copy)dispatch_block_t lightItemClickBlock;




@end
