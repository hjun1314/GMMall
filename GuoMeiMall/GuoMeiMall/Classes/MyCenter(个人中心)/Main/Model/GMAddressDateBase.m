//
//  GMAddressDateBase.m
//  GuoMeiMall
//
//  Created by hjun on 2018/4/17.
//  Copyright © 2018年 hjun. All rights reserved.
//

#import "GMAddressDateBase.h"
#import "GMAddressItem.h"
#import <FMDB.h>
@interface GMAddressDateBase(){
    FMDatabase *_db;
}
@end
static GMAddressDateBase *_dataBase = nil;

@implementation GMAddressDateBase
//dataBase数据
+ (instancetype)sharedDataBase{
    if (_dataBase == nil) {
        _dataBase = [[GMAddressDateBase alloc]init];
        [_dataBase initData];
    }
    return _dataBase;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if(_dataBase == nil){
        _dataBase = [super allocWithZone:zone];
    }
    return _dataBase;
    
}
- (void)initData{
    //文件路径
    NSString *filePath = [kPathDocument stringByAppendingPathComponent:@"address.sqlite"];
    //实例化FMDatabase
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    ///初始化数据表
    NSString *personSql = @"CREATE TABLE 'adress' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'adress_id' VARCHAR(255),'userName' VARCHAR(255),'userPhone' VARCHAR(255),'chooseAdress' VARCHAR(255),'userAdress' VARCHAR(255),'isDefault' VARCHAR(255))";
    [_db executeUpdate:personSql];
    [_db close];
}
/***新增地址**/
- (void)addNewAddress:(GMAddressItem *)address{
    [_db open];
    NSNumber *maxID = @(0);
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM adress"];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"adress_id"]integerValue]) {
            maxID = @([[res stringForColumn:@"adress_id"]integerValue]);
        }
    }
    maxID = @([maxID integerValue] + 1);
    [_db executeUpdate:@"INSERT INTO adress(adress_id,userName,userPhone,chooseAdress,userAdress,isDefault)VALUES(?,?,?,?,?,?)",maxID,address.userName,address.userPhone,address.chooseAdress,address.userAdress,address.isDefault];
    [_db close];
}

/***删除地址***/
- (void)deleteAddress:(GMAddressItem *)address{
    [_db open];
    
    [_db executeUpdate:@"DELETE FROM adress WHERE address_id = ?",address.ID];
    
    [_db close];
}

/***更新地址***/
- (void)updateAddress:(GMAddressItem *)adress{
    [_db open];
    
    [_db executeUpdate:@"UPDATE 'adress' SET userName = ?  WHERE adress_id = ? ",adress.userName,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET userPhone = ?  WHERE adress_id = ? ",adress.userPhone,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET chooseAdress = ? WHERE adress_id = ? ",adress.chooseAdress,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET userAdress = ? WHERE adress_id = ? ",adress.userAdress,adress.ID];
    [_db executeUpdate:@"UPDATE 'adress' SET isDefault = ?  WHERE adress_id = ? ",adress.isDefault,adress.ID];
    
    [_db close];
}

/***获取所有数据***/
- (NSMutableArray *)getAllAddressData{
    [_db open];
    NSMutableArray *dataArray = [NSMutableArray array];
    FMResultSet *res = [_db executeQuery:@"SELECT *FROM adress"];
    while ([res next]) {
        GMAddressItem *adressItem = [[GMAddressItem alloc] init];
        adressItem.ID = @([[res stringForColumn:@"adress_id"] integerValue]);
        adressItem.userName = [res stringForColumn:@"userName"];
        adressItem.userPhone = [res stringForColumn:@"userPhone"];
        adressItem.chooseAdress = [res stringForColumn:@"chooseAdress"];
        adressItem.userAdress = [res stringForColumn:@"userAdress"];
        adressItem.isDefault = [res stringForColumn:@"isDefault"];
        [dataArray addObject:adressItem];
    }
    
    [_db close];
    return dataArray;
}


@end
