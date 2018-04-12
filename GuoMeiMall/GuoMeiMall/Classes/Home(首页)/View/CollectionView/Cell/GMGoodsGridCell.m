//
//  GMGoodsGridCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMGoodsGridCell.h"
//models
#import "GMGoodsGridModel.h"
@interface GMGoodsGridCell()
@property (nonatomic,strong)UIImageView *gridImageView;
@property (nonatomic,strong)UILabel *gridLabel;
@property (nonatomic,strong)UILabel *tagLabel;

@end
@implementation GMGoodsGridCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI{
    _gridImageView = [[UIImageView alloc]init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc]init];
    _gridLabel.font = PFR13Font;
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
    
    _tagLabel = [[UILabel alloc]init];
    _tagLabel.font = PFR8Font;
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_tagLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(GMMargin);
        if (iPhone5) {
            make.size.mas_equalTo(CGSizeMake(38, 38));
        }else{
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }
        make.centerX.mas_equalTo(self);

    }];
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(_gridImageView.mas_bottom)setOffset:5];
    }];
    [_tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_gridImageView.mas_centerX);
        make.top.mas_equalTo(_gridImageView);
        make.size.mas_equalTo(CGSizeMake(35, 15));
    }];
}
- (void)setGoodsGrid:(GMGoodsGridModel *)goodsGrid{
    _goodsGrid = goodsGrid;
    _gridLabel.text = goodsGrid.gridTitle;
    _tagLabel.text = goodsGrid.gridTag;
    _tagLabel.textColor = [UIColor GM_colorWithHexString:goodsGrid.gridColor];
    _gridImageView.image = [UIImage imageNamed:goodsGrid.iconImage];
}
@end
