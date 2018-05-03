//
//  GMManagerController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

// Controllers
#import "GMManagerController.h"
#import "GMReceivedAddressController.h"
// Models

// Views
#import "GMUserMgHeadView.h"
#import "GMUserBgCell.h"
// Vendors

// Categories

// Others
@interface GMManagerController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)GMUserMgHeadView *mgHeadView;
@property (nonatomic,strong)NSArray *userMgItem;


@end
static NSString *const GMUserBgCellID = @"GMUserBgCellID";
@implementation GMManagerController

#pragma mark -- 懒加载

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMUserBgCell class]) bundle:nil] forCellReuseIdentifier:GMUserBgCellID];
    }
    return _tableView;
}

- (void)setupHeadView{
    _mgHeadView = [GMUserMgHeadView addViewFromXib];
    _mgHeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    self.tableView.tableHeaderView = _mgHeadView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 44;
}
- (void)setupBase{
    self.title = @"账号管理";
    self.view.backgroundColor = RGB(245, 245, 245);
    self.tableView.backgroundColor = self.view.backgroundColor;
    NSArray *titleArray = @[@"会员俱乐部",@"收货地址",@"实名认证",@"账户安全"];
    NSArray *subTitleArray = @[@"",@"",@"未认证",@"安全认证：中"];
    self.userMgItem = [NSArray arrayWithObjects:titleArray, subTitleArray,nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBase];
    [self setupHeadView];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
#pragma mark- tableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.userMgItem.firstObject;
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GMUserBgCell *cell = [tableView dequeueReusableCellWithIdentifier:GMUserBgCellID forIndexPath:indexPath];
    cell.titleLabelText.text = _userMgItem.firstObject[indexPath.row];
    cell.subTitleLabel.text = _userMgItem.lastObject[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GMReceivedAddressController *received = [[GMReceivedAddressController alloc]init];
    [self.navigationController pushViewController:received animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
