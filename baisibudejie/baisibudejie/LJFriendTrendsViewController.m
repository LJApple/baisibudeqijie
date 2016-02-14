//
//  LJFriendTrendsViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJFriendTrendsViewController.h"

@interface LJFriendTrendsViewController ()

@end

@implementation LJFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置左边的按钮
    UIButton *friendTagTrendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendTagTrendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendTagTrendsButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    friendTagTrendsButton.size = friendTagTrendsButton.currentBackgroundImage.size;
    
    [friendTagTrendsButton addTarget:self action:@selector(friendTagTrendsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendTagTrendsButton];
}

- (void) friendTagTrendsButtonClick
{
    LJLogFunc;
}
@end
