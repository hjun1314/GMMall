//
//  GMBeautyShopController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

// Controllers
#import "GMBeautyShopController.h"

// Models

// Views
#import "GMBeautyShopTopView.h"
#import "GMCycleHeadView.h"
#import "GMBeautyShopRecommendCell.h"
// Vendors

// Categories

// Others
@interface GMBeautyShopController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/***顶部按钮***/
@property (nonatomic,strong)GMBeautyShopTopView *topView;
/***轮播图***/
@property (nonatomic,strong)GMCycleHeadView *cycleHeadView;
@property (nonatomic,strong)UICollectionView *collectionView;

@end
static NSString *const GMCycleHeadViewID = @"GMCycleHeadView";
static NSString *const GMBeautyShopRecommandCellID = @"GMBeautyShopRecommandCell";
@implementation GMBeautyShopController

#pragma mark -- 懒加载

- (UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
//               [self.view addSubview:_collectionView];
        [self.view insertSubview:_collectionView atIndex:0];
        /***顶部轮播图***/
        [_collectionView registerClass:[GMCycleHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GMCycleHeadViewID];
        /***cell***/
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GMBeautyShopRecommendCell class]) bundle:nil] forCellWithReuseIdentifier:GMBeautyShopRecommandCellID];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopView];
    self.collectionView.backgroundColor = self.view.backgroundColor;
}
- (void)setupTopView{
    self.topView = [[GMBeautyShopTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight)];
    self.topView.openShopClickBlock = ^{
        DLog(@"点击了我要开店");
    };
    self.topView.messageClickBlock = ^{
        DLog(@"点击了消息");
    };
    [self.view addSubview:self.topView];
}
#pragma mark collectionViewDelegate&Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *beautyCell = nil;
    //    if (indexPath.section == 0) {
    GMBeautyShopRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GMBeautyShopRecommandCellID forIndexPath:indexPath];
    //        cell.backgroundColor = [UIColor orangeColor];
    beautyCell = cell;
    //    }
    return beautyCell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        //        if (indexPath.section == 0) {
        GMCycleHeadView *cycleHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:GMCycleHeadViewID forIndexPath:indexPath];
        cycleHeadView.cycleImageArray = GoodsBeautySilderImagesArray;
        reusableView = cycleHeadView;
        //        }
    }
    return reusableView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 380);
    }else if (indexPath.section == 1){
        return CGSizeMake(SCREEN_WIDTH, 200);
    }else if (indexPath.section == 2){
        return CGSizeMake(SCREEN_WIDTH, 222);
    }
    return CGSizeZero;
    
}
//设置头部
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 230);
    }else if (section == 2){
        return CGSizeMake(SCREEN_WIDTH, 35);
    }
    return CGSizeZero;
}
//设置尾部
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(SCREEN_WIDTH, GMMargin);
//}
#pragma mark- 下拉导航栏相应的变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.topView.hidden = (scrollView.contentOffset.y < 0)? YES :NO;
    _topView.backgroundColor = (scrollView.contentOffset.y > kTopHeight )? RGB(245, 245, 245):[UIColor clearColor];
    if (scrollView.contentOffset.y > kTopHeight) {
        [self.topView.openShopBtn setImage:[UIImage imageNamed:@"mshop_openmeidian_gray_icon"] forState:UIControlStateNormal];
        [self.topView.messageBtn setImage:[UIImage imageNamed:@"mshop_message_gray_icon"] forState:UIControlStateNormal];
    }else{
        [self.topView.openShopBtn setImage:[UIImage imageNamed:@"mshop_openmeidian_white_icon"] forState:UIControlStateNormal];
        [self.topView.messageBtn setImage:[UIImage imageNamed:@"mshop_message_white_icon"] forState:UIControlStateNormal];
    }
//    if (scrollView.contentOffset.y > kTopHeight) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
//    }else{
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
