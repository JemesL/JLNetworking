//
//  JLSecondWorldClient.h
//  JLNetWorking
//
//  Created by JL on 16/8/25.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLHTTPClient.h"

@interface JLSecondWorldClient : JLHTTPClient

+ (instancetype)sharedClient;

- (NSURLSessionDataTask *)TSWRequest:(NSString *)URLString
                           method:(HTTPMethodType)method
                             type:(JLClientRequestType)reqType
                       parameters:(id)parameters
                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
