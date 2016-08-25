//
//  ContentManager.m
//  JLNetWorking
//
//  Created by JL on 16/8/25.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "ContentManager.h"

@implementation ContentManager

static id _instance = nil;

+ (instancetype) sharedContentManager {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

- (BOOL)authorized
{
    return _secondWorldClient.authorized;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.secondWorldClient = [JLSecondWorldClient sharedClient];
    }
    return self;
}


@end
