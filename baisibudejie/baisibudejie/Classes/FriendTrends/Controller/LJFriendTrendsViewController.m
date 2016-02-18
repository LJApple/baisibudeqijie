//
//  LJFriendTrendsViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJFriendTrendsViewController.h"
#import "LJRecommendViewController.h"
#import "LJLoginRigsterViewController.h"

@interface LJFriendTrendsViewController ()

@end

@implementation LJFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(friendTrendsButtonClick)];
    // 设置背景颜色
   self.view.backgroundColor =  LJGlobalBg;
}

- (void) friendTrendsButtonClick
{
    LJRecommendViewController *vc = [[LJRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginClick:(id)sender {

    LJLoginRigsterViewController *login = [[LJLoginRigsterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}
@end
