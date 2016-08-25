//
//  UserCenter.h
//  JLNetWorking
//
//  Created by JL on 16/8/25.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLSecondWorldClient.h"

@interface UserCenter : NSObject

@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) JLSecondWorldClient *secondWorldClient;
@property (nonatomic) BOOL isLogined;
+ (instancetype) sharedUserCenter;
//- (BOOL)authorized;

#pragma mark Session
- (void)checkSessionIDWhenAppLaunch;
@end
