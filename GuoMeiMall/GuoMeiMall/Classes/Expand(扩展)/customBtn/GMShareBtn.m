//
//  GMShareBtn.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMShareBtn.h"

@implementation GMShareBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.centerX = self.width * 0.5;
    self.imageView.centerY = self.height * 0.3;
    [self.titleLabel sizeToFit];
    self.titleLabel.centerX = self.width *0.5;
    self.titleLabel.y = self.imageView.bottom + self.height *0.12;
}

@end
