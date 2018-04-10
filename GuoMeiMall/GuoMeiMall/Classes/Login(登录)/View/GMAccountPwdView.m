//
//  GMAccountPwdView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMAccountPwdView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIView+Toast.h"
#import "GMMediaListController.h"
#import "GMBeautyMessageController.h"
#import "GMHomeController.h"
#import "GMBeautyShopController.h"
@interface GMAccountPwdView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *PhoneNum;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;

@end
@implementation GMAccountPwdView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setBaseUI];
}
- (void)setBaseUI{
    _loginBtn.enabled = NO;
    _loginBtn.backgroundColor = [UIColor lightGrayColor];
    [_PhoneNum addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventValueChanged];
    [_Password addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventValueChanged];
    _PhoneNum.text = ([DCObjManager dc_readUserDataForKey:@"UserName"] == nil) ? nil :[DCObjManager dc_readUserDataForKey:@"UserName"];
    ///服务协议改变颜色
    [DCSpeedy dc_setSomeOneChangeColor:_agreeLabel SetSelectArray:@[@"《",@"》",@"服",@"务",@"协",@"议"] SetChangeColor:RGB(56, 152, 181)];
}

- (IBAction)didClickLoginBtn:(UIButton *)sender {
    [self endEditing:YES];

    [SVProgressHUD show];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    kWeakSelf(self);
    if ([self.PhoneNum.text isEqualToString:@"GMMall"]&& [self.Password.text isEqualToString:@"000"]) {
        [DCObjManager dc_saveUserData:@"1" forKey:@"isLogin"];//1代表登录
        [DCObjManager dc_saveUserData:self.PhoneNum.text forKey:@"UserName"];///记录用户名
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakself makeToast:@"登录成功" duration:0.5 position:CSToastPositionCenter];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:^{
                    [weakself endEditing:YES];
                    ///过滤控制器
                    if ([@[[GMHomeController class],[GMBeautyShopController class],[GMBeautyMessageController class],[GMMediaListController class]]containsObject:[[DCSpeedy dc_getCurrentVC]class]]) {
                        [[NSNotificationCenter defaultCenter]postNotificationName:LOGINSELECTCENTERINDEX object:nil];
                    }
                    
                }];
            });
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakself makeToast:@"账号密码错误请重新登录" duration:0.5 position:CSToastPositionCenter];
            
        });
        
    }
}
#pragma mark - <UITextFieldDelegate>
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_PhoneNum.text.length != 0 && _Password.text.length != 0) {
        _loginBtn.backgroundColor = RGB(252, 159, 149);
        _loginBtn.enabled = YES;
    }else{
        _loginBtn.enabled = NO;
        _loginBtn.backgroundColor = [UIColor lightGrayColor];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
