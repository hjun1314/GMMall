//
//  GMCenterShopCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMCenterShopCell.h"
@interface GMCenterShopCell()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *MeiShopBtn;
@end
@implementation GMCenterShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bottomView.backgroundColor = RGB(245, 245, 245);
    [DCSpeedy dc_chageControlCircularWith:_MeiShopBtn AndSetCornerRadius:15 SetBorderWidth:1 SetBorderColor:RGB(227, 107, 97) canMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
