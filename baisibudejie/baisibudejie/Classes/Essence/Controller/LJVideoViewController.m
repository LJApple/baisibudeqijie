//
//  LJVideoViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJVideoViewController.h"

@interface LJVideoViewController ()

@end

@implementation LJVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabeleView];
}

- (void)setTabeleView
{
    // 设置内边框
    CGFloat top = LJTitilesViewH + LJTitilesViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const ID = @"video";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@-------%zd", [self class], indexPath.row ];

    
    return cell;
}
@end
