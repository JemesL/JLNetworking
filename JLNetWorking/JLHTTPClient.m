//
//  JLHTTPClient.m
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLHTTPClient.h"
//#import "AFURLRequestSerialization.h"

@implementation JLHTTPClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    
    if ( self ) {
        
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    }
    return self;
}



- (NSURLSessionDataTask *)request:(NSString *)URLString method:(HTTPMethodType)method type:(JLClientRequestType)reqType parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if ( ![self setRequestSerializerByRequestType:reqType] ) {
        if ( failure ) failure(nil, [NSError errorWithDomain:kAPI_ERR_Domain code:kAPI_ERR_GeneralUnauthorized userInfo:nil]);  // Need Update
        return nil;
    }
    
    switch (method) {
        case HTTP_GET:
            
            return [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self processSuccessDataTask:task responseObject:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self processFailureDataTask:task error:error failure:failure];
            }];
            break;
        case HTTP_POST:{
            
//            NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
            return [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self processSuccessDataTask:task responseObject:responseObject success:success failure:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self processFailureDataTask:task error:error failure:failure];
            }];
        }
        default:
            break;
    }
    return nil;
}

- (NSString *)getErrorMsgWithStatusNum:(NSInteger)status
{
    switch (status) {
        case 0:
            return msgNormal;
        case 1:
            return msgRequestError;
            break;
        case 2:
            return msgNeedLoginAgain;
            break;
        case 4:
            return msgServiceError;
            break;
        default:
            return msgGeneralError;
            break;
    }
}

- (void)processSuccessDataTask:(NSURLSessionDataTask *)task
                responseObject:(id)responseObject
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSDictionary *dict = (NSDictionary *)responseObject;
    NSString *errcode;
    NSString *errmsg;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        errcode = [dict objectForKey:@"status"];
        errmsg = [self getErrorMsgWithStatusNum:[errcode integerValue]];
    }
    
    
    if ( [errcode integerValue] != 0) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        [userInfo setObject:errcode forKey:@"errcode"];
        [userInfo setObject:errmsg forKey:@"errmsg"];
        NSError *secondWorldError = [[NSError alloc] initWithDomain:kAPI_ERR_Domain code:[errcode integerValue] userInfo:userInfo];
        
        NSLog(@"API Error: %ld - %@", [errcode integerValue], errmsg);
        
        
        if ( failure ) failure(task, secondWorldError);
        
        [self handleErrorWithError:secondWorldError];
        
    } else {
        if ( success ) success(task, responseObject);
    }
}

- (void)handleErrorWithError:(NSError *)error
{
    if (error.code == 2) { // 需重新登录
        [self setClientUnauthorized];
        [[UserCenter sharedUserCenter] checkClientAuthorization];
    }
}

- (void)processFailureDataTask:(NSURLSessionDataTask *)task error:(NSError *)error failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    if ( failure ) failure(task, error);
    return;
    
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
//    
//    NSString *backfireCode = [httpResponse.allHeaderFields objectForKey:@"BackFire-Code"];
//    NSString *backfireMessage = [httpResponse.allHeaderFields objectForKey:@"BackFire-Message"];
//    if ( backfireCode ) {
//        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
//        [userInfo setObject:backfireCode forKey:@"errcode"];
//        [userInfo setObject:backfireMessage forKey:@"errmsg"];
//        NSError *backfireError = [[NSError alloc] initWithDomain:kAPI_ERR_Domain code:[backfireCode integerValue] userInfo:userInfo];
//        if ( failure ) failure(task, backfireError);
//    } else {
//        if (httpResponse.statusCode == 418)
//        {
//            NSError *err = [[NSError alloc] initWithDomain:kAPI_ERR_Domain code:418 userInfo:nil];
//            if ( failure ) failure(task, err);
//        }
//        else
//        {
//            if ( failure ) failure(task, error);
//        }
//    }
}

- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)setRequestSerializerByRequestType:(JLClientRequestType)reqType
{
    AFHTTPRequestSerializer <AFURLRequestSerialization> *reqSerializer = [self requestSerializerByRequestType:reqType];
    if ( !reqSerializer ) {
        return nil;
    }
    self.requestSerializer = reqSerializer;
    
    return reqSerializer;
}


- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializerByRequestType:(JLClientRequestType)reqType
{
    if ( reqType == JLReq_None ) {
        
        AFHTTPRequestSerializer *httpSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        return  httpSerializer;
        
    } else if ( ( reqType == JLReq_HTTP_Session ) || ( reqType == JLReq_HTTP_Authorized ) ) {
        
        AFHTTPRequestSerializer *httpSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        if ( reqType == JLReq_HTTP_Session ) {
            if ( _sessioned ) {
                [httpSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            } else {
                return nil;
            }
        } else {
            if ( _authorized ) {
                [httpSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            } else {
                return nil;
            }
        }
        return httpSerializer;
        
    } else if ( ( reqType == JLReq_JSON_Authorized ) || ( reqType ==  JLReq_JSON_Session ) ) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
        if (reqType == JLReq_JSON_Session) {
            AFJSONRequestSerializer *jsonSerializer = [AFJSONRequestSerializer serializer];
            
            if (_sessioned) {
                [jsonSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            } else {
                return nil;
            }
            return  jsonSerializer;
        } else {
            AFJSONRequestSerializer *jsonSerializer = [AFJSONRequestSerializer serializer];
            if (_authorized) {
                [jsonSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            } else {
                return nil;
            }
            return  jsonSerializer;
        }
        
        
    } else {
        
        return nil;
        
    }
}

- (void)setClientSessionBySessionID:(NSString *)sessionID
{
    [self.operationQueue cancelAllOperations];
    _sessionID = sessionID;
    _sessioned = (_sessionID);
    [[JLDataStore singletonStore] saveStringVariable:_sessionID forKey:kSavedSessionID];
}

//- (BOOL)checkClientSession
//{
//    _sessionID = [[JLDataStore singletonStore] getStringVariableByKey:kSavedSessionID];
//    _sessioned = (_sessionID);
//    return _sessioned;
//}

- (void)checkClientAuthorization
{
    _sessionID = [globalDataStore getStringVariableByKey:kSavedSessionID];
    _sessioned =  ( _sessionID );
    
    UserModel *user = (UserModel *)[globalDataStore getObjectVariableByKey:kSavedUserInfo];
    _authorized = ( user.userID ) && ( _sessionID );
    
    NSLog(@"_sessioned:%d  _authorized:%d",_sessioned,_authorized);
}

- (void)setClientUnauthorized
{
    [self.operationQueue cancelAllOperations];
    _sessionID = nil;
    _sessioned = NO;
    _authorized = NO;
    [UserCenter sharedUserCenter].user = nil;
    [globalDataStore saveStringVariable:_sessionID forKey:kSavedSessionID];
    [globalDataStore saveObjectVariable:nil forKey:kSavedUserInfo];
}

//- (void)checkAuthorization
//{
//    _sessionID = [globalDataStore getStringVariableByKey:kSavedSessionID];
//    
//}

- (void)matchDataModel:(Class)ModelClass responseObject:(id)responseObject failure:(void (^)(NSError *error))failure success:(void (^)(id parsedObject))success
{
    NSError *jsonParsingError;
    NSDictionary *dict = (NSDictionary *)responseObject;
    id parsedObject = [[ModelClass alloc] initWithDictionary:dict error:&jsonParsingError];
    
    if (jsonParsingError) {
        if ( failure ) failure(jsonParsingError);
    } else {
        if ( success ) success(parsedObject);
    }
}
@end
