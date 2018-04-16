//
//  GMUserBgCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMUserBgCell.h"
@interface GMUserBgCell()

@end
@implementation GMUserBgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}
- (void)setTitleLabelText:(UILabel *)titleLabelText{
    _titleLabelText = titleLabelText;
}
- (void)setSubTitleLabel:(UILabel *)subTitleLabel{
    _subTitleLabel = subTitleLabel;
    [DCSpeedy dc_setSomeOneChangeColor:_subTitleLabel SetSelectArray:@[@"低",@"中",@"高"] SetChangeColor:[UIColor orangeColor]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
