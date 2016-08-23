//
//  JLHTTPClient.m
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLHTTPClient.h"

@implementation JLHTTPClient

- (instancetype)initWithBaseURL:(NSURL *)url
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    
    if ( self ) {
        [self checkClientAuthorization];
    }
    return self;
}

- (void)checkClientAuthorization
{
    _sessionID = [globalDataStore getStringVariableByKey:kSavedSessionID];
    _authorized =  ( _sessionID );
}


- (NSURLSessionDataTask *)request:(NSString *)URLString method:(HTTPMethodType)method type:(JLClientRequestType)reqType parameters:(id)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    if ( ![self setRequestSerializerByRequestType:reqType] ) {
        if ( failure ) failure(nil, [NSError errorWithDomain:kAPI_ERR_Domain code:kAPI_ERR_GeneralUnauthorized userInfo:nil]);  // Need Update
        return nil;
    }
    
    
    
    return nil;
}

- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)setRequestSerializerByRequestType:(JLClientRequestType)reqType
{
    AFHTTPRequestSerializer <AFURLRequestSerialization> *reqSerializer = [self requestSerializerByRequestType:reqType];
    if ( !reqSerializer ) {
        return nil;
    }
    self.requestSerializer = reqSerializer;
//    if (kAPP_DEBUG_ENV)
//    {
//        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    }
    
    return reqSerializer;
}


- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializerByRequestType:(JLClientRequestType)reqType
{
    if (reqType) {
        
    }
    
    return nil;
}
@end
