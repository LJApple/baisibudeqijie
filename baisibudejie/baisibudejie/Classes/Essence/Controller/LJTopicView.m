//
//  LJStoryTellingViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJTopicView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import "LJTopics.h"
#import "LJTopicCell.h"

@interface LJTopicView  ()

/**
 *  段子数据
 */
@property (nonatomic, strong) NSMutableArray *topics;

/** 当前页码*/
@property (nonatomic, assign) NSInteger page;

/** 加载下一页数据时需要的参数*/
@property (nonatomic, copy) NSString *maxtime;
/** 上一次请求的参数*/
@property (nonatomic, strong) NSMutableDictionary *params;

@end

@implementation LJTopicView

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加刷新控件
    [self setupRefresh];
    
    // 设置内边距
    [self setTabeleView];
}

static NSString *const LJTopicID = @"topic";
- (void)setTabeleView
{
    // 设置内边框
    CGFloat top = LJTitilesViewH + LJTitilesViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 去掉分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 去除背景
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJTopicCell class]) bundle:nil] forCellReuseIdentifier:LJTopicID];
}

/*
 *  刷新新控件
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopic)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopic)];
    
}

#pragma mark - 数据处理
/**
 *  加载新的数据
 */
- (void)loadNewTopic
{
    [self.tableView.mj_footer endRefreshing];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    self.page = 0;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    [[AFHTTPSessionManager manager] POST:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // 获取模型数据
        
        self.topics = [LJTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        // 清空页码(当重新加载失败后要清空)
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
/**
 * 加载更多数据
 */
- (void)loadMoreTopic
{
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    // 页码
    self.page++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    [[AFHTTPSessionManager manager] POST:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典 模型
        NSArray *newTopics = [LJTopics mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LJTopicID];
    
    cell.topics = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型数据
    LJTopics *topic = self.topics[indexPath.row];
   
    return topic.cellHeight;
}
@end
