//
//  JLDataStore.m
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLDataStore.h"

@interface JLDataStore()

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@end

@implementation JLDataStore

static id _instance = nil;

+ (instancetype) singletonStore {
    if (_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSString *)getStringVariableByKey:(NSString *)key
{
    NSString *savedString = [_userDefaults stringForKey:key];
    return savedString;
}

- (void)saveStringVariable:(NSString *)stringValue forKey:(NSString *)key
{
    [_userDefaults setObject:stringValue forKey:key];
    [_userDefaults synchronize];
}

@end
