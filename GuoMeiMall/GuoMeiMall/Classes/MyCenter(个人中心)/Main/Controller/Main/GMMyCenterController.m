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
//models
//views
#import "GMMyCenterHeadView.h"//顶部headView
#import "GMMyCenterTopView.h"//顶部topView
@interface GMMyCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;
/****顶部headView*****/
@property (nonatomic,strong)GMMyCenterHeadView *headView;
/****头部背景图片***/
@property (nonatomic,strong)UIImageView *headBGImageView;
/****顶部导航栏item*****/
@property (nonatomic,strong)GMMyCenterTopView *topView;


@end

@implementation GMMyCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = RGB(245, 245, 245);
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
#pragma mark- 初始化headView
- (void)setupHeadView{
    self.tableView.tableHeaderView = self.headView;
    self.headBGImageView.frame = self.headView.bounds;
    [self.headView insertSubview:self.headBGImageView atIndex:0];
}
#pragma mark- 设置顶部导航栏
- (void)setupTopView{
    _topView = [[GMMyCenterTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    kWeakSelf(self);
    ///左边item点击
    _topView.leftItemClickBlock = ^{
        DLog(@"zzzz");
    };
    ///右边item点击
    _topView.rightItemClickBlock = ^{
        DLog(@"rrrr");
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
    static NSString *ID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = @"哈根达斯";
    return cell;
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
