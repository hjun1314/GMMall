//
//  GMAccordingRightBtn.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/14.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMAccordingRightBtn.h"

@implementation GMAccordingRightBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    /***设置label***/
    self.titleLabel.x = 0;
    self.titleLabel.centerY = self.centerY;
    [self.titleLabel sizeToFit];
    /***设置图片***/
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.centerY = self.centerY;
    [self.imageView sizeToFit];


}
@end
