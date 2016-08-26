//
//  JLDataStore.h
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLDataStore : NSObject

+ (instancetype) singletonStore;

- (NSString *)getStringVariableByKey:(NSString *)key;
- (void)saveStringVariable:(NSString *)stringValue forKey:(NSString *)key;


- (NSObject <NSCoding> *)getObjectVariableByKey:(NSString *)key;
- (void)saveObjectVariable:(NSObject <NSCoding> *)objValue forKey:(NSString *)key;
- (NSData *)getDataVariableByKey:(NSString *)key;
- (void)saveDataVariable:(NSData *)dataValue forKey:(NSString *)key;
@end
