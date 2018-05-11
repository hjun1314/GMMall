//
//  GMMyCenterController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//
//controllers
#import "GMMyCenterController.h"
#import "GMLoginController.h"
#import "GMManagerController.h"
#import "GMSettingController.h"
#import "GMScanningController.h"
//models
#import "GMGoodsGridModel.h"
#import "GMStateItem.h"
//views
#import "GMMyCenterHeadView.h"//顶部headView
#import "GMMyCenterTopView.h"//顶部topView
#import "GMCenterItemCell.h"//firstSection
#import "GMCenterServiceCell.h"//secondSection
#import "GMCenterShopCell.h"//thirdSection
#import "GMCenterBackCell.h"//fourthSection
//vendors
#import <MJExtension.h>
@interface GMMyCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
/****顶部headView*****/
@property (nonatomic,strong)GMMyCenterHeadView *headView;
/****头部背景图片***/
@property (nonatomic,strong)UIImageView *headBGImageView;
/****顶部导航栏item*****/
@property (nonatomic,strong)GMMyCenterTopView *topView;
/****四个cell的模型数据****/
@property (nonatomic,strong)NSMutableArray <GMStateItem *> *stateItem;
@property (nonatomic,strong)NSMutableArray <GMGoodsGridModel*> *goodsGrid;



@end
static NSString *const GMCenterItemCellID = @"GMCenterItemCellID";
static NSString *const GMCenterServiceCellID = @"CenterServiceCellID";
static NSString *const GMCenterShopCellID = @"GMCenterShopCellID";
static NSString *const GMCenterBackCellID = @"GMCenterBackCellID";
@implementation GMMyCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = RGB(245, 245, 245);
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero]; //去除多余分割线

    [self loadData];
    [self setupTopView];
    [self setupHeadView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark -- 懒加载

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[GMCenterItemCell class] forCellReuseIdentifier:GMCenterItemCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMCenterServiceCell class]) bundle:nil] forCellReuseIdentifier:GMCenterServiceCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMCenterShopCell class]) bundle:nil] forCellReuseIdentifier:GMCenterShopCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMCenterBackCell class]) bundle:nil] forCellReuseIdentifier:GMCenterBackCellID];
    }
    return _tableView;
}
- (UIImageView *)headBGImageView{
    if (_headBGImageView == nil) {
        _headBGImageView = [[UIImageView alloc]init];
        NSInteger armNum = [DCSpeedy dc_GetRandomNumber:1 to:9];
        [_headBGImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headBGImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headBGImageView setClipsToBounds:YES];
    }
    return _headBGImageView;
}
- (GMMyCenterHeadView *)headView{
    if (_headView == nil) {
        _headView = [GMMyCenterHeadView addViewFromXib];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }
    return _headView;
}
- (NSMutableArray<GMStateItem *> *)stateItem{
    if (_stateItem == nil) {
        _stateItem = [NSMutableArray array];
    }
    return _stateItem;
}
- (NSMutableArray<GMGoodsGridModel *> *)goodsGrid{
    if (_goodsGrid == nil) {
        _goodsGrid = [NSMutableArray array];
    }
    return _goodsGrid;
}
#pragma mark- 加载数据
- (void)loadData{
    _stateItem = [GMStateItem mj_objectArrayWithFilename:@"MyCenterFlow.plist"];
    _goodsGrid = [GMGoodsGridModel mj_objectArrayWithFilename:@"MyServiceFlow.plist"];
}
#pragma mark- 初始化headView
- (void)setupHeadView{
    self.tableView.tableHeaderView = self.headView;
    self.headBGImageView.frame = self.headView.bounds;
    [self.headView insertSubview:self.headBGImageView atIndex:0];
    kWeakSelf(self);
    self.headView.headClickBlock = ^{
        GMManagerController *manger = [[GMManagerController alloc]init];
        [weakself.navigationController pushViewController:manger animated:YES];
    };
    
}
#pragma mark- 设置顶部导航栏
- (void)setupTopView{
    _topView = [[GMMyCenterTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    kWeakSelf(self);
    ///左边item点击 扫描按钮
    _topView.leftItemClickBlock = ^{
        GMScanningController *scan = [[GMScanningController alloc]init];
        [weakself.navigationController pushViewController:scan animated:YES];
    };
    ///右边item点击
    _topView.rightItemClickBlock = ^{
        GMSettingController *setting = [[GMSettingController alloc]init];
        [weakself.navigationController pushViewController:setting animated:YES];
    };
    [self.view addSubview:_topView];

}
#pragma mark- tableviewDelegate&tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *customCell = [UITableViewCell new];
    if (indexPath.section == 0) {
        GMCenterItemCell * cell= [tableView dequeueReusableCellWithIdentifier:GMCenterItemCellID forIndexPath:indexPath];
        cell.stateItem = [NSMutableArray arrayWithArray:_stateItem];
        customCell = cell;
    }else if (indexPath.section == 1){
        GMCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:GMCenterServiceCellID forIndexPath:indexPath];
        cell.goodsGridArray = [NSMutableArray arrayWithArray:_goodsGrid];
        customCell = cell;
    }else if (indexPath.section == 2){
        GMCenterShopCell *cell = [tableView dequeueReusableCellWithIdentifier:GMCenterShopCellID forIndexPath:indexPath];
        customCell = cell;
    }else if (indexPath.section == 3){
        GMCenterBackCell *cell = [tableView dequeueReusableCellWithIdentifier:GMCenterBackCellID forIndexPath:indexPath];
        customCell = cell;
    }
    return customCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 188;
    }else if (indexPath.section == 1){
        return 213;
    }else if (indexPath.section == 2){
        return 288;
    }else if (indexPath.section == 3){
        return 200;
    }
    return 0;
}
//下拉滚动图片
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _topView.hidden = (scrollView.contentOffset.y < 0 )? YES : NO;
    _topView.backgroundColor = (scrollView.contentOffset.y > kTopHeight )? RGB(0, 0, 0):[UIColor clearColor];
    //图片高度
    CGFloat imageHeight = self.headView.height;
    //图片宽度
    CGFloat imageWidth = SCREEN_WIDTH;
    ///图片上下偏移量
    CGFloat imageOffset = scrollView.contentOffset.y;
    //上移
    if (imageOffset < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffset);
        CGFloat f = totalOffset / imageHeight;
        self.headBGImageView.frame = CGRectMake(-(imageWidth * f - imageWidth)*0.5, imageOffset, imageWidth * f, totalOffset);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
