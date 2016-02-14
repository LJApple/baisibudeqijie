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
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingButton.size = settingButton.currentBackgroundImage.size;
    [settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
   
    
    UIButton *moonModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    moonModeButton.size = moonModeButton.currentBackgroundImage.size;
    [moonModeButton addTarget:self action:@selector(moonModeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc] initWithCustomView:settingButton],
                                                [[UIBarButtonItem alloc] initWithCustomView:moonModeButton]
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
