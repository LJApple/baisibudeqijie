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
    
    
    [self setUp];
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
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (void)setUp
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
        LJRecommentCategory *re = self.categories[self.cateoryTableView.indexPathForSelectedRow.row];
        return re.users.count;
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
        LJRecommentCategory *re = self.categories[self.cateoryTableView.indexPathForSelectedRow.row];
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
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(re.id);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 左边列表的数据
            NSArray *users = [LJUserRecomendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            [re.users addObjectsFromArray:users];
            [self.userTableVIew reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }];
    }
}
@end
