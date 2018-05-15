//
//  GMStoresRecommendCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/15.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMStoresRecommendCell.h"
#import <UIImageView+WebCache.h>
#import "GMBeautyShopModel.h"
@interface GMStoresRecommendCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
@property (weak, nonatomic) IBOutlet UILabel *shopMoney;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *shelveBtn;

@end
@implementation GMStoresRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setBeautyShop:(GMBeautyShopModel *)beautyShop{
    _beautyShop = beautyShop;
    kWeakSelf(self);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:beautyShop.shopImageUrl] placeholderImage:[UIImage imageNamed:@"default_160"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        weakself.iconView.clipsToBounds = YES;
        weakself.iconView.layer.cornerRadius = 8;
    }];
    self.detailLabel.text = beautyShop.shopTitle;
    self.shopMoney.text = [NSString stringWithFormat:@"%@国美币",beautyShop.shopCommission];
    self.priceLabel.text =  [NSString stringWithFormat:@"¥ %@",beautyShop.shopAmount];
    
}
- (IBAction)didClickShelveBtn:(id)sender {
    !self.shelvesBtnClickBlock ? : self.shelvesBtnClickBlock();
}

@end
