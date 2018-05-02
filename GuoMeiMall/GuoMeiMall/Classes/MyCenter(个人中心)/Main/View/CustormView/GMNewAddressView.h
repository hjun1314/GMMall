//
//  GMNewAddressView.h
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCPlaceholderTextView.h"
@interface GMNewAddressView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *contactField;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet DCPlaceholderTextView *detailTextView;
@property (nonatomic,copy)dispatch_block_t addressBtn;

@end
