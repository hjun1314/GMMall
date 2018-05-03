//
//  GMAddressItem.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMAddressItem.h"

@implementation GMAddressItem
- (CGFloat)cellHeight{
    CGFloat top = 52;
    CGFloat bottom = 46;
    CGFloat middle = [DCSpeedy dc_calculateTextSizeWithText:[NSString stringWithFormat:@"%@%@",self.chooseAdress,self.userAdress] WithTextFont:14 WithMaxW:SCREEN_WIDTH - 24].height;
    return top + bottom + middle;
}
@end
