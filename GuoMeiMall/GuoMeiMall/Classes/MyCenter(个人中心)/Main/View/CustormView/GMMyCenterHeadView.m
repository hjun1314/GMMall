//
//  GMMyCenterHeadView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMMyCenterHeadView.h"
@interface GMMyCenterHeadView()
@property (weak, nonatomic) IBOutlet UIButton *lookVipBtn;

@end
@implementation GMMyCenterHeadView
- (void)awakeFromNib{
    [super awakeFromNib];
   ///设定头像圆角
    [DCSpeedy dc_chageControlCircularWith:_BtnIcon AndSetCornerRadius:_BtnIcon.width * 0.5 SetBorderWidth:1 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];
    _lookVipBtn.backgroundColor = RGB(252, 246, 213);
    [DCSpeedy dc_chageControlCircularWith:_lookVipBtn AndSetCornerRadius: 10 SetBorderWidth:1 SetBorderColor:RGB(252, 246, 213) canMasksToBounds:YES];
}

///头像点击
- (IBAction)didClickBtnIcon:(UIButton *)sender {
    !_headClickBlock ? : _headClickBlock();
    DLog(@"头像点击");
}
///查看会员点击
- (IBAction)didClickLookVipBtn:(UIButton *)sender {
    !_seePriceClickBlock ? : _seePriceClickBlock();
    DLog(@"查看会员点击");
}
///二维码点击
- (IBAction)didClickCodeBtn:(UIButton *)sender {
    !_qrClickBlock ? : _qrClickBlock();
    DLog(@"二维码点击");
}
///朋友圈点击
- (IBAction)didClickCircleOfFriends:(UIButton *)sender {
    !_friendCircleClickBlock ? : _friendCircleClickBlock();
    DLog(@"朋友圈点击");
}
///我的朋友点击
- (IBAction)didClickMyFriendsBtn:(UIButton *)sender {
    !_myFriendClickBlock ? : _myFriendClickBlock();
    DLog(@"我的朋友点击");
}


@end
