//
//  JLHTTPClient.h
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef enum {
    
    HTTP_NONE = 0,
    HTTP_GET,
    HTTP_POST,
    HTTP_PUT,
    HTTP_DELETE,
    HTTP_OPTIONS,
    HTTP_HEAD,
    HTTP_PATCH,
    HTTP_TRACE,
    HTTP_CONNECT
    
} HTTPMethodType;

typedef enum {
    
    JLReq_None = 0,
    JLReq_HTTP_RequestToken,
    JLReq_HTTP_Authorized,
    JLReq_HTTP_Public,
    JLReq_JSON_Authorized,
    JLReq_JSON_Public,
    
} JLClientRequestType;

@interface JLHTTPClient : AFHTTPSessionManager

@property (readonly, strong, nonatomic) NSString *accessToken;
@property (readonly, nonatomic) BOOL authorized;

@end
