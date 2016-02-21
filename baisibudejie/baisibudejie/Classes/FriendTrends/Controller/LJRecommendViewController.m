//
//  LJRecommendViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/15.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "LJRecommendViewController.h"
#import "LJCategoryTableViewCell.h"
#import <MJExtension.h>
#import "LJRecommentCategory.h"
#import "LJUserRecomendModel.h"
#import "LJUserTableViewCell.h"
#import <MJRefresh.h>

#define LJSelectCategory  self.categories[self.cateoryTableView.indexPathForSelectedRow.row]

/*
 CMD + CTRL + LEFT: 折叠
 CMD + CTRL + RIGHT: 取消折叠
 CMD + CTRL + TOP: 折叠全部函数
 CMD + CTRL + BOTTOM: 取消全部函数折叠
 CTRL + U: 取消全部折叠
*/
@interface LJRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cateoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableVIew;

/** 左边表格的数据*/
@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong)NSMutableDictionary *params;

@property (nonatomic, strong)AFHTTPSessionManager *manager;

@end

@implementation LJRecommendViewController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

static NSString * const LJCategoryID = @"category";
static NSString * const LJUsersID = @"users";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
     // 刷新控件
    [self setupRefresh];
   
    // 发送请求
    [self sendRequest];
    
}
#pragma setupRefresh
- (void)setupRefresh
{
    self.userTableVIew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableVIew.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
}
- (void)sendRequest
{
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // 服务器返回的JSON数据
        self.categories = [LJRecommentCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.cateoryTableView reloadData];
        // 默认首选中行
        [self.cateoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户进入下拉刷新状态
        [self.userTableVIew.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}


#pragma 加载新数据
- (void)loadNewUsers
{
    LJRecommentCategory *re = LJSelectCategory;
    // 设置当前页码
    re.currentPage = 1;
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(re.ID);
    params[@"next_page"] = @(re.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        // 左边列表的数据
        NSArray *users = [LJUserRecomendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        // 解决下拉刷新数据重复的问题
        [re.users removeAllObjects];
        
        [re.users addObjectsFromArray:users];
        // LJLog(@"%@", responseObject);
        
        // 保存总数
        re.total = [responseObject[@"total"] integerValue];
        
        // 解决重复请求,不是最后一次
        if (self.params != params)return ;

        // 刷行右边的表格
        [self.userTableVIew reloadData];
        // 结束刷新
        [self.userTableVIew.mj_header endRefreshing];
        
        // 判断下拉刷新是否加载完毕
        [self checkOutRefresh];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 提醒加载失败
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        
        [self.userTableVIew.mj_header endRefreshing];
    }];

}

- (void)loadMoreUser {

    LJRecommentCategory *re = LJSelectCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([LJSelectCategory ID]);
    params[@"page"] = @(++re.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        // 左边列表的数据
        NSArray *users = [LJUserRecomendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [re.users addObjectsFromArray:users];
        
        // 如果发现最后一次的请求和临时创建地是否是同一个
        if (self.params != params) return ;
        
        [self.userTableVIew reloadData];
        // 让底部提醒结束刷行
        [self checkOutRefresh];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];

}

- (void)checkOutRefresh
{
    LJRecommentCategory *re = LJSelectCategory;
    if (re.users.count == re.total) {
        // 全部数据已经加载完毕
        [self.userTableVIew.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableVIew.mj_footer endRefreshing];
    }
}

#pragma mark - setUpTableView
- (void)setUpTableView
{
    // 注册
    [self.cateoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJCategoryTableViewCell class]) bundle: nil] forCellReuseIdentifier:LJCategoryID];
    [self.userTableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([LJUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:LJUsersID];
    
    self.userTableVIew.rowHeight = 70;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cateoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableVIew.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.cateoryTableView.contentInset = self.userTableVIew.contentInset;
    self.title = @"推荐关注";
    // 设置背景颜色
    self.view.backgroundColor = LJGlobalBg;
}


#pragma mark - <UITableViewDateSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.cateoryTableView) {
        return self.categories.count;
    } else  {
        NSInteger count = [LJSelectCategory users].count ;
        // 每次都刷新右边时，控制footer显示或则隐藏
        self.userTableVIew.mj_footer.hidden = (count == 0);
        
        // 让底部控件结束刷新
        [self checkOutRefresh];
        return count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.cateoryTableView) {
        LJCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LJCategoryID];
        
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        LJUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LJUsersID];
        LJRecommentCategory *re = LJSelectCategory;
        cell.users = re.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新,解决连续点击数据出现的问题
    [self.userTableVIew.mj_header endRefreshing];
    [self.userTableVIew.mj_footer endRefreshing];
    
    LJRecommentCategory *re = self.categories[indexPath.row];
    
    //[self.userTableVIew.mj_footer  endRefreshingWithNoMoreData];
    if (re.users.count) {
        // 显示原来的数据
        [self.userTableVIew reloadData];
    } else  {
        // 赶紧刷新表格不让用户看到残留数据
        [self.userTableVIew reloadData];
        //进入下拉刷新状态
        [self.userTableVIew.mj_header beginRefreshing];
    }
}

#pragma mark -控制器的销毁
- (void) dealloc
{
    // 停止所有操作,当控制器死了
    [self.manager.operationQueue cancelAllOperations];
}
@end
