//
//  GMStateItemCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMStateItemCell.h"
#import "GMStateItem.h"
@interface GMStateItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *stateItemBgView;
@property (weak, nonatomic) IBOutlet UIButton *stateButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
@implementation GMStateItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}
- (void)setStateItem:(GMStateItem *)stateItem{
    _stateItem = stateItem;
    self.stateItemBgView.backgroundColor = (stateItem.bgColor)?RGB(245, 245, 245):[UIColor whiteColor];
    if (stateItem.showImage) {
        [self.stateButton setImage:[UIImage imageNamed:stateItem.imageContent] forState:UIControlStateNormal];
    }else{
        [self.stateButton setTitle:stateItem.imageContent forState:UIControlStateNormal];
    }
    self.stateLabel.text = stateItem.stateTitle;
}
@end
