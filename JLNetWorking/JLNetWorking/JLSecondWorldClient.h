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

@end
