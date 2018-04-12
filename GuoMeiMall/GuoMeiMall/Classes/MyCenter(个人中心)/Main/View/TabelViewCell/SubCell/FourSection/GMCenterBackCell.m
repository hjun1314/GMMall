//
//  GMCenterBackCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMCenterBackCell.h"
@interface GMCenterBackCell()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end
@implementation GMCenterBackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [DCSpeedy dc_chageControlCircularWith:_backBtn AndSetCornerRadius:15 SetBorderWidth:1 SetBorderColor:RGB(227, 107, 97) canMasksToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
