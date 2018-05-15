//
//  GMBeautyPageControl.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/15.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMBeautyPageControl.h"

@implementation GMBeautyPageControl

#pragma mark - 重写setCurrentPage方法更改PageControl的大小和图片
- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    for (NSUInteger i = 0; i < self.subviews.count; i++) {
        UIImageView *subView = [self.subviews objectAtIndex:i];
        CGSize size;
        size.height = 6;
        size.width = 6;
        subView.frame = CGRectMake(subView.x, subView.y, size.width, size.height);
    }
}


@end
