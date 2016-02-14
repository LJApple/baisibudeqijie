//
//  LJEssenceViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJEssenceViewController.h"
#import "LJtestViewController.h"

@interface LJEssenceViewController ()

@end

@implementation LJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(essenceButtonClick)];
    
    // 设置背景颜色
    self.view.backgroundColor =  LJGlobalBg;
}

- (void)essenceButtonClick
{
    LJLogFunc;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LJtestViewController *vc = [[LJtestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    LJLog(@"%@", self.navigationController);
}
@end
