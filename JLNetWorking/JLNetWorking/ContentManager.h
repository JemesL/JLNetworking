//
//  ContentManager.h
//  JLNetWorking
//
//  Created by JL on 16/8/25.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLSecondWorldClient.h"

@interface ContentManager : NSObject

@property (nonatomic, strong) JLSecondWorldClient *secondWorldClient;

+ (instancetype) sharedContentManager;
- (BOOL)authorized;

- (void)getHomepageHotArticleListWithPass:(NSString *)pass
                                  Success:(void (^)(ArticleIndexModel *articleIndex))success
                                  failure:(void (^)(NSError *error))failure;

@end
