//
//  GMTabController.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/9.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,GMTabBarControllerType){
    GMTabControllerMeiXin = 0,
    GMTabControllerHome = 1,
    GMTabControllerMediaList = 2,
    GMTabControllerBeautyStore = 3,
    GMTabControllerPerson = 4,
    
};
@interface GMTabController : UITabBarController

@property (nonatomic,assign)GMTabBarControllerType tabVCtype;


@end
