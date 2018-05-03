//
//  GMNewAddressController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

// Controllers
#import "GMNewAddressController.h"

// Models
#import "GMAddressItem.h"
#import "GMAddressDateBase.h"
// Views
#import "GMNewAddressView.h"
// Vendors
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"
#import "UIView+Toast.h"
#import <SVProgressHUD.h>
// Categories

// Others
@interface GMNewAddressController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)GMNewAddressView *addressView;
@property (nonatomic,strong)ChooseLocationView *chooseLocationView;
@property (nonatomic,strong)UIView *cover;

@end

@implementation GMNewAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBase];
    [self setupAddressView];
}


- (void)setupBase{
    self.title = (_saveType == GMSaveAddressNewType) ? @"新增收货人地址":@"编辑收货人地址";
    self.view.backgroundColor = RGB(245, 245, 245);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = self.view.backgroundColor;

    ///添加地址信息数据
    [[CitiesDataTool sharedManager]requestGetData];
    UIBarButtonItem *negativeSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpace.width = -15;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.titleLabel.font = PFR16Font;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[negativeSpace,rightItem];
    
}
#pragma mark- 点击了rightItem保存
- (void)didClickSaveBtn{
    [self.view endEditing:YES];
    if (self.addressView.regionLabel.text.length == 0 && self.addressView.nameField.text.length == 0 && self.addressView.contactField.text.length == 0 && self.addressView.detailTextView.text == 0) {
        [self.view makeToast:@"当前编辑为空" duration:0.8 position:CSToastPositionCenter];
        return;
    }
    NSString *address = (self.addressView.regionLabel.text == nil) ? @"" : self.addressView.regionLabel.text;
    NSArray *storeArray = @[self.addressView.nameField.text,self.addressView.contactField.text,address,self.addressView.detailTextView.text];
    [DCObjManager dc_saveUserData:storeArray forKey:@"StoreAddress"];
    [self.view makeToast:@"保存成功" duration:0.5 position:CSToastPositionCenter];
}
#pragma mark- 点击了页面底部按钮保存
- (IBAction)didClickAddBtn:(UIButton *)sender {
    if (self.addressView.nameField.text.length == 0 ||
        self.addressView.contactField.text.length == 0 ||
        self.addressView.regionLabel.text.length == 0 ||
        self.addressView.detailTextView.text.length == 0) {
        [self.view makeToast:@"请填写完整地址信息" duration:0.5 position:CSToastPositionCenter];
        [DCSpeedy dc_callFeedback];//触动效果
        return;
    }
    if (![DCCheckRegular dc_checkTelNumber:self.addressView.contactField.text]) {
        [self.view makeToast:@"输入的电话号码格式不对，请重新输入" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    GMAddressItem *addressItem = (_saveType == GMSaveAddressNewType)? [GMAddressItem new] :_addressItem;
    addressItem.userName = self.addressView.nameField.text;
    addressItem.userPhone = self.addressView.contactField.text;
    addressItem.userAdress = self.addressView.detailTextView.text;
    addressItem.chooseAdress = self.addressView.regionLabel.text;
    addressItem.isDefault = @"1";
    if (self.saveType == GMSaveAddressNewType) {
        [[GMAddressDateBase sharedDataBase]addNewAddress:addressItem];
    }else if (self.saveType == GMSaveAddressEditType){
        [[GMAddressDateBase sharedDataBase]updateAddress:addressItem];
    }
    kWeakSelf(self);
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [weakself.view makeToast:@"保存成功" duration:0.8 position:CSToastPositionCenter];
        [DCObjManager dc_removeUserDataForkey:@"StoreAddress"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"updateStore" object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        });
        
    });
    
}
#pragma mark- 设置addressView
- (void)setupAddressView{
    self.addressView = [GMNewAddressView addViewFromXib];
    self.addressView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    self.tableView.tableHeaderView = self.addressView;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if (_saveType == GMSaveAddressEditType) {
        self.addressView.nameField.text = _addressItem.userName;
        self.addressView.contactField.text = _addressItem.userPhone;
        self.addressView.regionLabel.text = _addressItem.chooseAdress;
        self.addressView.detailTextView.text = _addressItem.userAdress;
    }else if (_saveType == GMSaveAddressNewType &&
    [DCObjManager dc_readUserDataForKey:@"StoreAddress"] != nil){
        /***存储编辑信息***/
     NSArray *storeAddressArray = [DCObjManager dc_readUserDataForKey:@"StoreAddress"];
        self.addressView.nameField.text = storeAddressArray[0];
        self.addressView.contactField.text = storeAddressArray[1];
        self.addressView.regionLabel.text = storeAddressArray[2];
        self.addressView.detailTextView.text = storeAddressArray[3];
        
    }
    kWeakSelf(self);
    //添加地址按钮点击方法
     self.addressView.addressBtn = ^{
        [weakself.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakself.cover.hidden = !weakself.cover.hidden;
            weakself.chooseLocationView.hidden = weakself.cover.hidden;
        });
    };
}

#pragma mark -- 懒加载

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, kTopHeight + 20, SCREEN_WIDTH, SCREEN_HEIGHT - (kTopHeight + 20 + 44));
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIView *)cover{
    if (_cover == nil) {
        _cover = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        kWeakSelf(self);
        _chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
                weakself.addressView.regionLabel.text = weakself.chooseLocationView.address;
                weakself.cover.hidden = YES;
            }];
        };
        [self.view addSubview:_cover];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesCover:)];
        tap.delegate = self;
        [_cover addGestureRecognizer:tap];
        _cover.hidden = YES;
    }
    return _cover;
}
- (ChooseLocationView *)chooseLocationView{
    if (_chooseLocationView == nil) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 350, SCREEN_WIDTH, 350)];
    }
    return _chooseLocationView;
}
#pragma mark- cover点击方法
- (void)tapGesCover:(UITapGestureRecognizer *)tapges{
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}
#pragma mark- tapges代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseLocationView.frame, point)) {
        return NO;
    }
    return YES;
}
#pragma mark- tableViewDelegate&tableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString  *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
