//
//  LJMeViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJMeViewController.h"

@interface LJMeViewController ()

@end

@implementation LJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // 设置导航栏的标题
    self.navigationItem.title = @"我的";
    
    //  设置右边的按钮
    // setting
    UIBarButtonItem *settingButtonClick = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingButtonClick)];
    // moon
    UIBarButtonItem *moonModeButtonClick = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonModeButtonClick)];
    
    self.navigationItem.rightBarButtonItems = @[
                                                settingButtonClick,
                                                moonModeButtonClick
                                                ];
}

- (void)settingButtonClick
{
    LJLogFunc;
}
- (void)moonModeButtonClick
{
    LJLogFunc;
}


@end
