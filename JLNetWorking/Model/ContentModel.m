//
//  ContentModel.m
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "ContentModel.h"

@implementation ArticleModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:
            @{
              @"_id": @"articleID",
              @"user": @"user",
              @"title": @"title",
              @"content": @"content",
              @"game_tag": @"gameTag",
              @"type_tag": @"typeTag",
              @"money": @"money",
              @"is_liked": @"iliked",
              @"liked_number": @"likeCnt",
              @"time": @"createTime",
              @"is_collected": @"iCollected",
              @"picture_list" : @"pictures",
              @"video_list": @"videos",
              @"view_number": @"viewCnt",
              @"comment_number": @"commentCnt"
              }];
}
            
@end

@implementation CommentModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:
          @{
            @"user_id":@"userID",
            @"user_nickname":@"userNickName",
            @"user_head_image":@"userHeadImage",
            @"content":@"content",
            @"is_liked":@"iliked",
            @"liked_number":@"likeCnt",
            @"time":@"createTime",
           }];
}

@end

@implementation BannerModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:
            @{
              @"image":@"image",
              @"hyper_text":@"urlStr",
              }];
}

@end


@implementation EventModel

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:
            @{
              @"_id":@"eventID",
              @"event_type":@"eventType",
              @"user_id": @"userID",
              @"user_nickname": @"userNickName",
              @"user_head_image": @"userHeadImage",
              @"content": @"content",
              @"time": @"createTime",
              @"source_article_id": @"originArticleID",
              @"source_article_content": @"originArticleContent",
              }];
}

@end

