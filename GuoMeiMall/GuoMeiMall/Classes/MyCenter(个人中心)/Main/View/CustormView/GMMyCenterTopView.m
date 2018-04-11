//
//  GMMyCenterTopView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMMyCenterTopView.h"
@interface GMMyCenterTopView()
@property (nonatomic,strong)UIButton *leftItemButton;
@property (nonatomic,strong)UIButton *rightItemButton;


@end
@implementation GMMyCenterTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    _leftItemButton = ({
        UIButton * button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"group_home_scan"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    self.rightItemButton = [UIButton new];
    [self.rightItemButton setImage:[UIImage imageNamed:@"mine_whitesetting"] forState:UIControlStateNormal];
    [self.rightItemButton addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftItemButton];
    [self addSubview:_rightItemButton];
    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
    [self.layer addSublayer:layer];
}
#pragma mark- 布局
- (void)layoutSubviews{
    [super layoutSubviews];
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
}
#pragma 自定义右边导航Item点击
- (void)rightButtonItemClick {
    !_rightItemClickBlock ? : _rightItemClickBlock();
}

#pragma 自定义左边导航Item点击
- (void)leftButtonItemClick {
    
    !_leftItemClickBlock ? : _leftItemClickBlock();

}
@end
