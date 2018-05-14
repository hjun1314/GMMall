//
//  GMBeautyShopTopView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMBeautyShopTopView.h"
@interface GMBeautyShopTopView()

/***通知***/
@property (nonatomic,weak)id topViewObserve;




@end
@implementation GMBeautyShopTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setNotifi];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    self.openShopBtn = [[UIButton alloc]init];
    [self.openShopBtn setImage:[UIImage imageNamed:@"mshop_openmeidian_white_icon"] forState:UIControlStateNormal];
    [self.openShopBtn addTarget:self action:@selector(didClickOpenShopBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.openShopBtn];
    
    self.messageBtn = [[UIButton alloc ]init];
    [self.messageBtn setImage:[UIImage imageNamed:@"mshop_message_white_icon"] forState:UIControlStateNormal];
    [self.messageBtn addTarget:self action:@selector(didClickmessageBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.messageBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.openShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.width.height.equalTo(@44);
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.openShopBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(0);
        make.width.height.offset(44);
    }];
}
- (void)setNotifi{
    kWeakSelf(self);
    self.topViewObserve = [[NSNotificationCenter defaultCenter]addObserverForName:SHOWTOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakself.backgroundColor = [UIColor whiteColor];
        [weakself.openShopBtn setImage:[UIImage imageNamed:@"mshop_openmeidian_gray_icon"] forState:UIControlStateNormal];
        [weakself.messageBtn setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateNormal];
    }];
    
    self.topViewObserve = [[NSNotificationCenter defaultCenter]addObserverForName:HIDETOPTOOLVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakself.backgroundColor = [UIColor clearColor];
        [weakself.openShopBtn setImage:[UIImage imageNamed:@"mshop_openmeidian_white_icon"] forState:UIControlStateNormal];
        [weakself.messageBtn setImage:[UIImage imageNamed:@"mshop_message_white_icon"] forState:UIControlStateNormal];
    }];
    
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self.topViewObserve];
}
- (void)didClickOpenShopBtn{
    !self.openShopClickBlock ? : self.openShopClickBlock();
}

- (void)didClickmessageBtn{
    !self.messageClickBlock ? : self.messageClickBlock();
}
@end
