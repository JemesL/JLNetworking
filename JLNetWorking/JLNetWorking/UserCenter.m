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
    }
    return self;
}

- (void)checkSessionIDWhenAppLaunch
{
    if (![self.secondWorldClient checkClientSession]) {
        
        [_secondWorldClient request:@"aquire_session_id" method:HTTP_GET type:JLReq_None parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSString *sessionStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            [self.secondWorldClient setClientSessionBySessionID:sessionStr];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"%@",error);
            
        }];
    }
}


@end
