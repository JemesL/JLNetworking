//
//  UserModel.h
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol UserModel

@end
@interface UserModel : JSONModel

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString <Optional> *sex;
@property (nonatomic, strong) NSString <Optional> *nickName;
@property (nonatomic, strong) NSString <Optional> *headImage;
@property (nonatomic, strong) NSString <Optional> *info;

@end
