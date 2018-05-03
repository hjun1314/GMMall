//
//  GMReceivedAddressController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

// Controllers
#import "GMReceivedAddressController.h"
#import "GMNewAddressController.h"
// Models
#import "GMAddressItem.h"
#import "GMAddressDateBase.h"
// Views
#import "GMUserAddressCell.h"
// Vendors
#import <SVProgressHUD.h>
#import "UIView+Toast.h"
// Categories

// Others

@interface GMReceivedAddressController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong , nonatomic)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray <GMAddressItem *> *addressItem;

@end

static NSString *GMUserAddressCellID = @"GMUserAddressCellID";

@implementation GMReceivedAddressController
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GMUserAddressCell class]) bundle:nil] forCellReuseIdentifier:GMUserAddressCellID];
        
    }
    return _tableView;
}
- (NSMutableArray<GMAddressItem *> *)addressItem{
    if (_addressItem == nil) {
        _addressItem = [NSMutableArray array];
    }
    return _addressItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBase];
    [self setNotifi];
}
- (void)setupBase{
    self.title = @"收货地址";
    self.view.backgroundColor = RGB(245, 245, 245);
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [UIView new];
    self.addressItem = [[GMAddressDateBase sharedDataBase]getAllAddressData];
    UIButton *button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:@"nav_btn_tianjia"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)didClickButton{
    GMNewAddressController *addAddress = [[GMNewAddressController alloc]init];
    addAddress.saveType = GMSaveAddressNewType;
    [self.navigationController pushViewController:addAddress animated:YES];
}
#pragma mark- 保存按钮通知回调
- (void)setNotifi{
    kWeakSelf(self);
    [[NSNotificationCenter defaultCenter]addObserverForName:@"updateStore" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        weakself.addressItem = [[GMAddressDateBase sharedDataBase]getAllAddressData];
        [weakself.tableView reloadData];
    }];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark- delegate&datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressItem.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GMUserAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:GMUserAddressCellID forIndexPath:indexPath];
    cell.addressItem = self.addressItem[indexPath.row];
    kWeakSelf(self);
    /***删除按钮***/
    cell.deleteBtnBlock = ^{
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [weakself.view makeToast:@"删除成功" duration:0.8 position:CSToastPositionCenter];
            [[GMAddressDateBase sharedDataBase]deleteAddress:weakself.addressItem[indexPath.row]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakself.addressItem removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            });
        });
    };
    /***编辑按钮***/
    cell.editBtnBlock = ^{
        GMNewAddressController *address = [[GMNewAddressController alloc]init];
        address.addressItem = weakself.addressItem[indexPath.row];
        address.saveType = GMSaveAddressEditType;
        [weakself.navigationController pushViewController:address animated:YES];
    };
    /***默认选中按钮***/
    cell.selectDefauleBtn = ^(BOOL isSelect) {

        for (NSInteger i = 0; i < weakself.addressItem.count; i++) {
            GMAddressItem *addressItem = weakself.addressItem[i];
            addressItem.isDefault = (i == indexPath.row && isSelect) ? @"2" : @"1";
            [[GMAddressDateBase sharedDataBase]updateAddress:addressItem];
        }
        weakself.addressItem = [[GMAddressDateBase sharedDataBase]getAllAddressData];
        [weakself.tableView reloadData];
    };

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.addressItem[indexPath.row].cellHeight;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
