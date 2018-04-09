//
//  GMNewFeatureCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMNewFeatureCell.h"
@interface GMNewFeatureCell()
@property (strong , nonatomic)UIButton *hideButton;

@end
@implementation GMNewFeatureCell
#pragma mark - super
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _nfImageView = [[UIImageView alloc] init];
        [self insertSubview:_nfImageView atIndex:0];
        
    }
    return self;
}

#pragma mark - LazyLaod
- (UIButton *)hideButton
{
    if (!_hideButton) {
        _hideButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideButton.adjustsImageWhenHighlighted = false;
        _hideButton.hidden = YES;
        [_hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_hideButton];
        
    }
    return _hideButton;
}

#pragma mark - super
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.nfImageView.frame = self.bounds;
}

- (void)setHideBtnImg:(NSString *)hideBtnImg
{
    _hideBtnImg = hideBtnImg;
    if (hideBtnImg.length != 0) {
        [self.hideButton sizeToFit]; //自适应
        
        [self.hideButton setImage:[UIImage imageNamed:hideBtnImg] forState:UIControlStateNormal];
        self.hideButton.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.9);
    }
}

#pragma mark - 获取页码index
- (void)dc_GetCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex
{
    _hideButton.hidden = (currentIndex == lastIndex) ?  NO : YES; //只有当前index和最后index相等时隐藏按钮才显示
}

#pragma mark - 隐藏点击
- (void)hideButtonClick
{
    !_hideButtonClickBlock ? : _hideButtonClickBlock(); //block回调
}

@end
