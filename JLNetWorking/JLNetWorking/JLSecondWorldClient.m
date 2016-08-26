//
//  JLSecondWorldClient.m
//  JLNetWorking
//
//  Created by JL on 16/8/25.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLSecondWorldClient.h"

@implementation JLSecondWorldClient

static id _instance = nil;

+ (instancetype) sharedClient {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        });
    }
    return _instance;
}


- (NSURLSessionDataTask *)TSWRequest:(NSString *)URLString
                              method:(HTTPMethodType)method
                                type:(JLClientRequestType)reqType
                          parameters:(id)parameters
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *newParameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    switch (reqType) {
        case JLReq_None:
            break;
        
        case JLReq_JSON_Session:{
            [newParameters setObject:[globalDataStore getStringVariableByKey:kSavedSessionID] forKey:@"session_id"];
            break;
        }
        case JLReq_JSON_Authorized:{
            UserModel *user = (UserModel *)[globalDataStore getObjectVariableByKey:kSavedUserInfo];
            [newParameters setObject:[globalDataStore getStringVariableByKey:kSavedSessionID] forKey:@"session_id"];
            [newParameters setObject:user.userID forKey:@"object_id"];
        }
        default:
            break;
    }
    
    return [self request:URLString method:method type:reqType parameters:newParameters success:success failure:failure];
}
@end
