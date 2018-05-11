//
//  GMScanTopView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMScanTopView.h"
@interface GMScanTopView()
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIButton *pickBtn;
@property (nonatomic,strong)UIButton *lightBtn;

@end
@implementation GMScanTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    self.backBtn = [[UIButton alloc]init];
    [self.backBtn setImage:[UIImage imageNamed:@"starsq_sandbox-btn_back"] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backBtn];
    
    self.pickBtn = [[UIButton alloc]init];
    [self.pickBtn setImage:[UIImage imageNamed:@"scan_photo_album"] forState:UIControlStateNormal];
    [self.pickBtn addTarget:self action:@selector(clickPickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.pickBtn];
    self.lightBtn = [[UIButton alloc]init];
    [self.lightBtn setImage:[UIImage imageNamed:@"starsq_sandbox-btn_camera_light"] forState:UIControlStateNormal];
    [self.lightBtn addTarget:self action:@selector(clickLightBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.lightBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(GMMargin);
        make.height.width.equalTo(@35);
    }];
    
    [self.lightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-GMMargin);
        make.height.width.equalTo(@35);
    }];
    
    [self.pickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backBtn.mas_centerY);
        make.right.equalTo(self.lightBtn.mas_left).offset(-GMMargin);
        make.height.width.offset(35);
    }];
}
- (void)clickBackBtn{
    !self.backItemClickBlock ? : self.backItemClickBlock();
}

- (void)clickPickBtn{
    !self.pickItemClickBlock ? : self.pickItemClickBlock();
}

- (void)clickLightBtn{
    !self.lightItemClickBlock ? : self.lightItemClickBlock();
}
@end
