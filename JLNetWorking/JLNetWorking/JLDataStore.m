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
    if (_instance == nil) {
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


- (NSObject <NSCoding> *)getObjectVariableByKey:(NSString *)key
{
    NSData *data = [self getDataVariableByKey:key];
    if (data == nil) return nil;
    
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return obj;
}
- (void)saveObjectVariable:(NSObject <NSCoding> *)objValue forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:objValue];
    [self saveDataVariable:data forKey:key];
}
- (NSData *)getDataVariableByKey:(NSString *)key
{
    NSData *savedData = [_userDefaults dataForKey:key];
    return savedData;
}
- (void)saveDataVariable:(NSData *)dataValue forKey:(NSString *)key
{
    [_userDefaults setObject:dataValue forKey:key];
    [_userDefaults synchronize];
}

@end
