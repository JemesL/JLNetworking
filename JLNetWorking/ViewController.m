//
//  ViewController.m
//  JLNetWorking
//
//  Created by JL on 16/8/23.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
//    [[UserCenter sharedUserCenter] loginWithPhone:@"15857913627" password:@"123" success:^(UserModel *user) {
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
    [[ContentManager sharedContentManager] getHomepageHotArticleListWithPass:nil Success:^(ArticleIndexModel *articleIndex) {
        
//        NSLog(@"%@",articleIndex.articles);
        [articleIndex.articles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ArticleModel *article = (ArticleModel *)obj;
            NSLog(@"%@",article.articleID);
        }];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
