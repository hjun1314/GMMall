//
//  GMCenterItemCell.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/12.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMCenterItemCell.h"
///views
#import "GMStateItemCell.h"
#import "GMStateItemReusableView.h"
//vendors
//#import <MJExtension.h>
//models
#import "GMStateItem.h"
@interface GMCenterItemCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView *collectionView;


@end
static NSString *const GMStateItemCellID = @"GMStateItemCellID";
static NSString *const GMStateItemReusableViewID = @"GMStateItemReusableViewID";
@implementation GMCenterItemCell
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        ///注册cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GMStateItemCell class]) bundle:nil] forCellWithReuseIdentifier:GMStateItemCellID];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}
- (NSMutableArray<GMStateItem *> *)stateItem{
    if (_stateItem == nil) {
        _stateItem = [NSMutableArray array];
    }
    return _stateItem;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = RGB(245, 245, 245);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
#pragma mark- collectionviewDelegate & dataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _stateItem.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GMStateItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GMStateItemCellID forIndexPath:indexPath];
    cell.stateItem = _stateItem[indexPath.row];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = [[UICollectionReusableView alloc]init];
    if (kind == UICollectionElementKindSectionFooter) {
        GMStateItemReusableView *reus = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionFooter withReuseIdentifier:GMStateItemReusableViewID forIndexPath:indexPath];
        reusableView = reus;
    }
    return reusableView;
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH / 5, 90);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0);
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
