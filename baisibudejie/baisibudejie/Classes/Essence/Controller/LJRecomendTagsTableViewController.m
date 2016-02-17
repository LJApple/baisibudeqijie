//
//  LJRecomendTagsTableViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/17.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJRecomendTagsTableViewController.h"
#import "LJRecomendTags.h"
#import "LJRecomentTagsCell.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface LJRecomendTagsTableViewController ()

@property (nonatomic, strong) NSArray *tags;
@end

@implementation LJRecomendTagsTableViewController

static NSString * const LJRecomendTagID = @"tags";
-(void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化
    [self setUpRecomendTags];
    
    [self loadRecomendTags];
}
/**
 *  对tableView的设置
 */
- (void)setUpRecomendTags {
    
    self.title = @"推荐标签";
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJRecomentTagsCell class]) bundle:nil] forCellReuseIdentifier:LJRecomendTagID];
    self.tableView.rowHeight = 70;
    self.tableView.separatorColor = UITableViewCellAccessoryNone;
    self.tableView.backgroundColor = LJGlobalBg;
}

/**
 *  对数据的访问
 */
- (void)loadRecomendTags {
    // 设置
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"c"] = @"topic";
    params[@"action"] = @"sub";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典转模型数据
        self.tags = [LJRecomendTags mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LJRecomentTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:LJRecomendTagID forIndexPath:indexPath];
    cell.recomendTags = self.tags[indexPath.row];
    return cell;
}

@end
