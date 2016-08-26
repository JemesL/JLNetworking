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

- (void)getHomepageHotArticleListWithPass:(NSString *)pass Success:(void (^)(ArticleIndexModel *articleIndex))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    pass ? [pass setValue:pass forKey:@"pass"] : nil;
    [_secondWorldClient TSWRequest:@"get_homepage_hot_article_list" method:HTTP_POST type:JLReq_JSON_Authorized parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_secondWorldClient matchDataModel:[ArticleIndexModel class] responseObject:responseObject failure:failure success:success];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];
}


@end
