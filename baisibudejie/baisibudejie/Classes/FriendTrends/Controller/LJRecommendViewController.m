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

@interface LJRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cateoryTableView;

/** 左边表格的数据*/
@property (nonatomic, strong) NSArray *categories;
@end

@implementation LJRecommendViewController

static NSString * const LJCategoryID = @"category";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.cateoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LJCategoryTableViewCell class]) bundle: nil] forCellReuseIdentifier:LJCategoryID];
    
    self.title = @"推荐关注";
    
    // 设置背景颜色
    self.view.backgroundColor = LJGlobalBg;
    
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
#pragma mark - <UITableViewDateSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LJCategoryID];
    
    cell.category = self.categories[indexPath.row];
    return cell;
}
@end
