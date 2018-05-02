//
//  GMNewAddressController.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMAddressItem;
typedef NS_ENUM(NSUInteger,GMSaveAddressType){
    GMSaveAddressNewType = 0,//保存
    GMSaveAddressEditType = 1, //编辑
};
@interface GMNewAddressController : UIViewController

@property (nonatomic,assign)GMSaveAddressType saveType;

@property (nonatomic,strong)GMAddressItem *addressItem;

@end
