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

@end
