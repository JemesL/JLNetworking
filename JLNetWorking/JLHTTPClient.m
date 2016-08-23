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
//        _authorizing = NO;
        //
        [self checkClientAuthorization];
    }
    return self;
}

- (void)checkClientAuthorization
{
//    _accessToken = [globalDataStore getStringVariableByKey:kSavedAccessToken];
//    _accessTokenType = [globalDataStore getStringVariableByKey:kSavedAccessTokenType];
//    _authorized = ( _accessTokenType ) && ( _accessToken );
    _authorized =  ( _accessToken );
}


@end
