//
//  GMBeautyShopRecommendCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/13.
//  Copyright © 2018年 hjun. All rights reserved.
//

// Controllers

// Models

// Views
#import "GMBeautyShopRecommendCell.h"
#import "GMStoresRecommendCell.h"
#import "GMBeautyPageControl.h"
// Vendors

// Categories

// Others
@interface GMBeautyShopRecommendCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,strong)GMBeautyPageControl *pageControl;

@end
static NSString *const GMStoresRecommendCellID = @"GMStoresRecommendCell";
@implementation GMBeautyShopRecommendCell
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GMStoresRecommendCell class]) bundle:nil] forCellWithReuseIdentifier:GMStoresRecommendCellID];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self setUpPageControl];
}
- (void)setUpPageControl{
    self.pageControl = [[GMBeautyPageControl alloc]init];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.numberOfPages = 4;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    self.pageControl.hidesForSinglePage = YES;
    [self addSubview:self.pageControl];
}
#pragma mark- delegate&datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    GMStoresRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GMStoresRecommendCellID forIndexPath:indexPath];
    cell.beautyShop = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_collectionView.width / 3, _collectionView.height);
}
#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(_topView.mas_bottom).offset(GMMargin);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self).offset(-5);
        make.bottom.equalTo(_bottomView.mas_top).offset(-GMMargin);
    }];
    _pageControl.frame = CGRectMake(self.width * 0.5 - 40, self.bottomView.y - GMMargin, 80, GMMargin);
}
@end
