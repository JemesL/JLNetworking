//
//  ContentModel.h
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ArticleModel
@end

@interface ArticleModel: JSONModel

@property (nonatomic, strong) NSString *articleID;
@property (nonatomic, strong) UserModel <Optional> *user;
@property (nonatomic, strong) NSString <Optional> *title;
@property (nonatomic, strong) NSString <Optional> *content;
@property (nonatomic, strong) NSString <Optional> *gameTag;
@property (nonatomic, strong) NSString <Optional> *typeTag;
@property (nonatomic, strong) NSNumber <Optional> *money;
@property (nonatomic, strong) NSNumber <Optional>*iliked;
@property (nonatomic, strong) NSNumber <Optional>*likeCnt;
@property (nonatomic, strong) NSString <Optional> *createTime;
@property (nonatomic, strong) NSNumber <Optional> *iCollected;
@property (nonatomic, strong) NSArray <Optional> *pictures;
@property (nonatomic, strong) NSArray <Optional> *videos;
@property (nonatomic, strong) NSNumber <Optional> *viewCnt;
@property (nonatomic, strong) NSNumber <Optional> *commentCnt;

@end


@protocol CommentModel
@end

@interface CommentModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *userID;
@property (nonatomic, strong) NSString <Optional> *userNickName;
@property (nonatomic, strong) NSString <Optional> *userHeadImage;
@property (nonatomic, strong) NSString <Optional> *content;
@property (nonatomic, strong) NSNumber <Optional> *iliked;
@property (nonatomic, strong) NSNumber <Optional> *likeCnt;
@property (nonatomic, strong) NSString <Optional> *createTime;

@end



@protocol BannerModel
@end

@interface BannerModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *image;
@property (nonatomic, strong) NSString <Optional> *urlStr;


@end