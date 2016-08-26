//
//  UserModel.m
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:
              @{
                @"object_id": @"userID",
                @"sex": @"sex",
                @"nickname": @"nickName",
                @"head_image": @"headImage",
                @"user_brief_infor": @"info",
                }];
}

@end
