//
//  GMCenterServiceCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMCenterServiceCell.h"
#import "GMGoodsGridCell.h"
@interface GMCenterServiceCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topView;


@end
static NSString *const GMCenterServiceCellID = @"GMCenterServiceCellID";
@implementation GMCenterServiceCell

#pragma mark -- 懒加载

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        [_collectionView registerClass:[GMGoodsGridCell class] forCellWithReuseIdentifier:GMCenterServiceCellID];
    }
    return _collectionView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(_topView.mas_bottom);
        make.bottom.mas_equalTo(self).mas_offset(-10);
    }];
}
#pragma mark- collectionViewDelegate&DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _goodsGridArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GMGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GMCenterServiceCellID forIndexPath:indexPath];
    cell.goodsGrid = _goodsGridArray[indexPath.row];
    return cell;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH / 4, 85);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
