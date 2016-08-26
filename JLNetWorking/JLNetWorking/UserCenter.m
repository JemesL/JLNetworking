//
//  UserCenter.m
//  JLNetWorking
//
//  Created by JL on 16/8/25.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "UserCenter.h"

@implementation UserCenter


static id _instance = nil;

+ (instancetype) sharedUserCenter {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.secondWorldClient = [JLSecondWorldClient sharedClient];
        self.user = (UserModel *)[globalDataStore getObjectVariableByKey:kSavedUserInfo];
    }
    return self;
}

- (void)checkClientAuthorization
{
    [_secondWorldClient checkClientAuthorization];
    
    [self checkSessionID];
}

- (BOOL)isLogined
{
    return _secondWorldClient.authorized;
}

- (void)setIsLogined:(BOOL)isLogined
{
    _secondWorldClient.authorized = isLogined;
}

- (void)checkSessionID
{
//    if (YES) {
    if (self.secondWorldClient.sessioned == NO) {
        
        [_secondWorldClient TSWRequest:@"aquire_session_id" method:HTTP_GET type:JLReq_None parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSString *sessionStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self.secondWorldClient setClientSessionBySessionID:sessionStr];

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }
}

- (void)storeUserInfo
{
    [globalDataStore saveObjectVariable:_user forKey:kSavedUserInfo];
}

- (void)removeUserInfo
{
    [globalDataStore saveObjectVariable:nil forKey:kSavedUserInfo];
}

- (void)resginerUserWithPhone:(NSString *)phoneNumber password:(NSString *)password code:(NSString *)code success:(void (^)(NSString *, NSString *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    phoneNumber ? [params setObject:phoneNumber forKey:@"phone_number"] : nil;
    password ? [params setObject:password forKey:@"password"] : nil;
    code ? [params setObject:code forKey:@"code"] : nil;
    
    [_secondWorldClient TSWRequest:@"auth_resginer_message" method:HTTP_POST type:JLReq_HTTP_Session parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *sessionID = [responseObject valueForKey:@"session_id"];
        NSString *userID = [responseObject valueForKey:@"user_id"];
        if (success) success(sessionID,userID);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];
}

- (void)loginWithPhone:(NSString *)phoneNumber
              password:(NSString *)password
               success:(void (^)(UserModel *user))success
               failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    phoneNumber ? [params setValue:phoneNumber forKey:@"phone_number"] : nil;
    password ? [params setValue:password forKey:@"password"] : nil;
    
    [_secondWorldClient TSWRequest:@"login" method:HTTP_POST type:JLReq_JSON_Session parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [_secondWorldClient matchDataModel:[UserModel class] responseObject:responseObject failure:failure success:^(id parsedObject) {
            // save userinfo
            UserModel *cUser = (UserModel *)parsedObject;
            self.user = cUser;
            [self storeUserInfo];
            [self checkClientAuthorization];
            
            if (success) success(responseObject);
        }];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ( failure ) failure(error);
        
    }];
}
@end
