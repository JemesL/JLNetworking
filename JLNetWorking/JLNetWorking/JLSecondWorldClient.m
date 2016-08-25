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

@end
