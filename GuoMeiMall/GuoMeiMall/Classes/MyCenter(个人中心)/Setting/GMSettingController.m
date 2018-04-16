//
//  GMSettingController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/16.
//  Copyright © 2018年 hjun. All rights reserved.
//

// Controllers
#import "GMSettingController.h"
#import "GMLoginController.h"
// Models

// Views
#import "GMUserBgCell.h"
#import "GMUserMgHeadView.h"
// Vendors
#import <SVProgressHUD.h>
#import "UIView+Toast.h"
// Categories

// Others
@interface GMSettingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)GMUserMgHeadView *headView;
@property (nonatomic,strong)NSArray *userMgItem;


@end
static NSString *const GMUserBgCellID = @"GMUserBgCell";
@implementation GMSettingController

#pragma mark -- 懒加载

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
        [self.view addSubview:self.tableView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMUserBgCell class]) bundle:nil] forCellReuseIdentifier:GMUserBgCellID];
    }
    return _tableView;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeadView];
    [self setupBase];
    [self setUpLoginOff];
}
- (void)setupHeadView{
    _headView = [GMUserMgHeadView addViewFromXib];
    _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    self.tableView.tableHeaderView = _headView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableFooterView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 46;
}
- (void)setupBase{
    self.title = @"账号管理";
    self.view.backgroundColor = RGB(245, 245, 245);
    self.tableView.backgroundColor = self.view.backgroundColor;
    NSArray *titleArray = @[@"会员俱乐部",@"收货地址",@"实名认证",@"账户安全"];
    NSArray *subTitleArray = @[@"",@"",@"未认证",@"安全认证：中"];
    self.userMgItem = [NSArray arrayWithObjects:titleArray, subTitleArray,nil];
}
#pragma mark - 退出登录
- (void)setUpLoginOff
{
    UIView *footerView = [UIView new];
    
    UIButton *loginOffButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOffButton setTitle:@"退出登录" forState:0];
    loginOffButton.backgroundColor = RGB(235, 103, 98);
    loginOffButton.frame = CGRectMake(15, 35, SCREEN_WIDTH - 30, 45);
    [loginOffButton addTarget:self action:@selector(loginOffClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginOffButton];
    [DCSpeedy dc_setUpBezierPathCircularLayerWithControl:loginOffButton size:CGSizeMake(GMMargin, GMMargin)];
    footerView.height = 80;
    self.tableView.tableFooterView = footerView;
}
- (void)loginOffClick{
    kWeakSelf(self);
    [DCSpeedy dc_SetUpAlterWithView:self Message:@"是否确定退出登录" Sure:^{
        [DCObjManager dc_removeUserDataForkey:@"isLogin"];
        [SVProgressHUD show];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakself.view makeToast:@"退出登录成功" duration:0.5 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                GMLoginController *login = [[GMLoginController alloc]init];
                //                [weakself.navigationController popToRootViewControllerAnimated:YES];
                [weakself presentViewController:login animated:YES completion:^{
                    [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil]; //退出登录
                }];
                [weakself.navigationController popToRootViewControllerAnimated:YES];
                
            });
        });
    } Cancel:^{
        
    }];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
