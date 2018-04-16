//
//  GMStateItemReusableView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMStateItemReusableView.h"

@implementation GMStateItemReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    _footerImageView = [[UIImageView alloc]init];
    [self addSubview:_footerImageView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_footerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(GMMargin);
        make.bottom.mas_equalTo(self).mas_offset(-GMMargin);
        make.left.right.mas_equalTo(self);
    }];
}
@end
