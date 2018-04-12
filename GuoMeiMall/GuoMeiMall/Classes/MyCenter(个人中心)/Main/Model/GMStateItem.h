//
//  GMStateItem.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMStateItem : NSObject
/* 显示文字图片 */
@property (nonatomic, assign) BOOL showImage;

/* 图片或数字 */
@property (nonatomic, copy) NSString *imageContent;

/* 标题 */
@property (nonatomic, copy) NSString *stateTitle;

/* 背景色 */
@property (nonatomic, assign) BOOL bgColor;
@end
