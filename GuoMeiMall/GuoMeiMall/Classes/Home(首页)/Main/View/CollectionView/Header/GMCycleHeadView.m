//
//  GMCycleHeadView.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/13.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMCycleHeadView.h"
#import <SDCycleScrollView.h>
@interface GMCycleHeadView()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;

@end
@implementation GMCycleHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.height) delegate:self placeholderImage:nil];
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    self.cycleScrollView.autoScrollTimeInterval = 3;
    [self addSubview:self.cycleScrollView];
}

- (void)setCycleImageArray:(NSArray *)cycleImageArray{
    _cycleImageArray = cycleImageArray;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_160"];
    if (cycleImageArray.count == 0) {
        return;
    }
    self.cycleScrollView.imageURLStringsGroup = self.cycleImageArray;
}

#pragma mark- 点击图片跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"点击了%zd轮播图",index);
}

@end
