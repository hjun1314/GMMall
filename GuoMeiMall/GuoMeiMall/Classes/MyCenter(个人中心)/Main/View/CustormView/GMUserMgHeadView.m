//
//  GMUserMgHeadView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMUserMgHeadView.h"
@interface GMUserMgHeadView()
@property (weak, nonatomic) IBOutlet UIButton *iconViewBtn;
@property (weak, nonatomic) IBOutlet UIView *headBgView;

@end
@implementation GMUserMgHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    [DCSpeedy dc_setUpBezierPathCircularLayerWithControl:self.iconViewBtn size:CGSizeMake(self.iconViewBtn.width * 0.5, self.iconViewBtn.height * 0.5)];
    self.headBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickHeadBgView)];
    [self addGestureRecognizer:tap];
}
///头部头像点击
- (IBAction)didIconViewBtn:(UIButton *)sender {
    !_headButtonClickBlock ? : _headButtonClickBlock();
    DLog(@"头部头像");
}
///二维码点击
- (IBAction)didQRCodeBtn:(UIButton *)sender {
    !_erCodeClickBlock ? : _erCodeClickBlock();
    DLog(@"二维码");
}
///我的主页点击
- (IBAction)didMyHomePageBtn:(UIButton *)sender {
    !_myHomeClickBlock ? : _myHomeClickBlock();
    DLog(@"主页");
}
///头部view点击
- (void)didClickHeadBgView{
    !_headViewTouchBlock ? : _headViewTouchBlock();
    DLog(@"头部view");
}

@end
