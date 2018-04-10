//
//  GMLoginController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMLoginController.h"
// Views
#import "GMAccountPwdView.h"
#import "GMPhoneRegistView.h"
@interface GMLoginController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *middleView;
/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;
//账号密码登陆
@property (nonatomic,strong)GMAccountPwdView *accountPwdView;
///短信验证登陆
@property (nonatomic,strong)GMPhoneRegistView *phoneRegistView;




@end

@implementation GMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setupTitleView];
    [self setupContentView];
}
- (void)setupTitleView{
    _titleView = [UIView new];
    _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 35);
    [_middleView addSubview:_titleView];
    
    NSArray *titleArray = @[@"账号密码登陆",@"短信验证登录"];
    CGFloat btnW = (_titleView.width - 30) / 2;
    CGFloat btnH = _titleView.height - 3;
    CGFloat btnX = 15;
    CGFloat btnY = 0;
    for (NSInteger i = 0; i<titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.font = PFR16Font;
        btn.tag = i;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX + i * btnW, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(didClickTitleViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView addSubview:btn];
    }
    UIButton *firstButton = _titleView.subviews[0];
    [self didClickTitleViewBtn:firstButton];
    _indicatorView = [UIView new];
    _indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [firstButton.titleLabel sizeToFit];
    
    _indicatorView.height = 2;
    _indicatorView.width = firstButton.titleLabel.width;
    _indicatorView.centerX = firstButton.centerX;
    _indicatorView.y = _titleView.bottom - _indicatorView.height;
    [_titleView addSubview:_indicatorView];
    self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH * titleArray.count, 0);

}
///按钮点击
- (void)didClickTitleViewBtn:(UIButton *)button{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _selectBtn = button;
    kWeakSelf(self);
    [UIView animateWithDuration:0.25 animations:^{
        weakself.indicatorView.width = button.titleLabel.width;
        weakself.indicatorView.centerX = button.centerX;
    }];
    CGPoint offset = _contentView.contentOffset;
    offset.x = _contentView.width * button.tag;
    [_contentView setContentOffset:offset animated:YES];
}
- (void)setupContentView{
    self.contentView.backgroundColor = [UIColor orangeColor];
    self.contentView.frame = CGRectMake(0, self.titleView.bottom + GMMargin, SCREEN_WIDTH, _middleView.height - _titleView.bottom - GMMargin);
    [self.middleView addSubview:_contentView];
    
    _accountPwdView = [GMAccountPwdView addViewFromXib];
    [_contentView addSubview:_accountPwdView];
    _phoneRegistView = [GMPhoneRegistView addViewFromXib];
    [_contentView addSubview:_phoneRegistView];
    
    _phoneRegistView.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _middleView.height - _titleView.height);
    _accountPwdView.frame = CGRectMake(0, 0, SCREEN_WIDTH,  _middleView.height - _titleView.height);
    
}
#pragma mark- scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = _titleView.subviews[index];
    [self didClickTitleViewBtn:button];
}
///dissmiss
- (IBAction)backBtn:(UIButton *)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
///注册
- (IBAction)registeBtn:(UIButton *)sender {
}

#pragma mark -- 懒加载

- (UIScrollView *)contentView{
    
    if (_contentView == nil) {
        
        _contentView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.bounces = NO;
        _contentView.pagingEnabled = YES;
        _contentView.delegate = self;
    }
    return _contentView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
