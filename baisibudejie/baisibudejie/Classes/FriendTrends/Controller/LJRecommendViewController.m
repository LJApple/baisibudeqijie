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

@interface LJRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cateoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableVIew;

/** 左边表格的数据*/
@property (nonatomic, strong) NSArray *categories;

@end

@implementation LJRecommendViewController

static NSString * const LJCategoryID = @"category";
static NSString * const LJUsersID = @"users";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setUpTableView];
    
     // 刷新控件
    [self setupRefresh];
   
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        // 服务器返回的JSON数据
        self.categories = [LJRecommentCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
    // 刷新表格
        [self.cateoryTableView reloadData];
        // 默认首选中行
        [self.cateoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

#pragma setupRefresh
- (void)setupRefresh
{
    self.userTableVIew.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
}

- (void)loadMoreUser {

    LJRecommentCategory *re = LJSelectCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([LJSelectCategory id]);
    params[@"page"] = @(++re.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 左边列表的数据
        NSArray *users = [LJUserRecomendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [re.users addObjectsFromArray:users];
        
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
    
    LJRecommentCategory *re = self.categories[indexPath.row];
    
    if (re.users.count) {
        // 显示原来的数据
        [self.userTableVIew reloadData];
    } else  {
        // 赶紧刷新表格不让用户看到残留数据
        [self.userTableVIew reloadData];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(re.id);
        params[@"next_page"] = @(re.currentPage);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 左边列表的数据
            NSArray *users = [LJUserRecomendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // 设置当前页码
            re.currentPage = 1;
            [re.users addObjectsFromArray:users];
            LJLog(@"%@", responseObject);
            
            // 保存总数
            re.total = [responseObject[@"total"] integerValue];
            // 刷行右边的表格
            [self.userTableVIew reloadData];
            // 检查刷新
            [self checkOutRefresh];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];
    }
}
@end
