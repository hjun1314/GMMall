//
//  GMScanningController.m
//  GuoMeiMall
//
//  Created by hjun on 2018/5/11.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMScanningController.h"
#import "GMScanTopView.h"
@interface GMScanningController ()<DCScanBackDelegate>
/***顶部View***/
@property (nonatomic,strong)GMScanTopView *topView;

@end

@implementation GMScanningController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanDelegate = self;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self setupTopView];
}
- (void)setupTopView{
    self.topView = [[GMScanTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kTopHeight)];
    kWeakSelf(self);
    self.topView.backItemClickBlock = ^{
        [weakself.navigationController popViewControllerAnimated:YES];
    };
    self.topView.pickItemClickBlock = ^{
        [weakself jumpPhotoAlbum];
    };
    self.topView.lightItemClickBlock = ^{
        [weakself flashButtonClick:weakself.flashButton];
        
    };
    [self.view addSubview:self.topView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
