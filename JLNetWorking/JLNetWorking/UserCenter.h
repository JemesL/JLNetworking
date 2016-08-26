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
- (void)checkClientAuthorization;

- (void)resginerUserWithPhone:(NSString *)phoneNumber
                     password:(NSString *)password
                         code:(NSString *)code
                      success:(void (^)(NSString *sessionID, NSString *userID))success
                      failure:(void (^)(NSError *error))failure;


- (void)loginWithPhone:(NSString *)phoneNumber
              password:(NSString *)password
               success:(void (^)(UserModel *user))success
               failure:(void (^)(NSError *error))failure;



- (void)changeNicknameWithNewname:(NSString *)newNickname
                          success:(void (^)(NSDictionary *dict))success
                          failure:(void (^)(NSError *error))failure;
@end
