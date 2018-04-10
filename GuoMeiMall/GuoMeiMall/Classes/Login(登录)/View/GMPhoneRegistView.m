//
//  GMPhoneRegistView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMPhoneRegistView.h"
@interface GMPhoneRegistView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *verificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;

@end
@implementation GMPhoneRegistView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupBaseUI];
}
- (void)setupBaseUI{
    _loginBtn.enabled = _verificationBtn.enabled = NO;
    _loginBtn.backgroundColor = _verificationBtn.backgroundColor = [UIColor lightGrayColor];
    [_userNameTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventValueChanged];
    [_verificationTextField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventValueChanged];
    [DCSpeedy dc_setSomeOneChangeColor:_agreeLabel SetSelectArray:@[@"《",@"》",@"服",@"务",@"协",@"议"] SetChangeColor:RGB(56, 152, 181)];
}
#pragma mark- uitextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_userNameTextField.text.length != 0) {
        _verificationBtn.backgroundColor = RGB(252, 159, 149);
        _verificationBtn.enabled = YES;
    }else{
        _verificationBtn.backgroundColor = [UIColor lightGrayColor];
        [_verificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verificationBtn.enabled = NO;
    }
    if (_userNameTextField.text.length != 0 && _verificationTextField.text.length != 0) {
        _loginBtn.enabled = YES;
        _loginBtn.backgroundColor = RGB(252, 159, 149);
    }else{
        _loginBtn.enabled = NO;
        _loginBtn.backgroundColor = [UIColor lightGrayColor];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

///验证码点击
- (IBAction)didClickVerificationBtn:(UIButton *)sender {
    __block NSInteger time = 59;//倒计时时间
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    ///每秒执行
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    kWeakSelf(self);
    dispatch_source_set_event_handler(timer, ^{
        if (time <= 0) {///倒计时结束，关闭
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                ///重新设置按钮
                [weakself.verificationBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                weakself.verificationBtn.userInteractionEnabled = YES;
            });
            
        }else{
            NSInteger second = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                [weakself.verificationBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2ld)",(long)second] forState:UIControlStateNormal];
                weakself.verificationBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(timer);
    
}
@end
