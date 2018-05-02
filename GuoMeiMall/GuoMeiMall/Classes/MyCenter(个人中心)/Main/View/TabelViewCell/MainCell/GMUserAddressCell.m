//
//  GMUserAddressCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/2.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMUserAddressCell.h"
#import "GMAddressItem.h"
#import "DCSpeedy.h"
@interface GMUserAddressCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation GMUserAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setAddressItem:(GMAddressItem *)addressItem{
    _addressItem = addressItem;
    self.nameLabel.text = addressItem.userName;
    self.phoneLabel.text = [DCSpeedy dc_encryptionDisplayMessageWith:addressItem.userPhone WithFirstIndex:3];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@",addressItem.chooseAdress,addressItem.userAdress];
    if ([addressItem.isDefault isEqualToString:@"2"]) {
        /***默认选中***/
        self.defaultBtn.selected = YES;
        
    }else{
        self.defaultBtn.selected = NO;
    }
}
- (IBAction)didClickDefaultBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    !self.selectDefauleBtn ? : self.selectDefauleBtn(sender.selected);
    
}
- (IBAction)didClickDeleteBtn:(UIButton *)sender {
    !self.deleteBtnBlock ? : self.deleteBtnBlock();
}
- (IBAction)didClickEditBtn:(UIButton *)sender {
    !self.editBtnBlock ? : self.editBtnBlock();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
