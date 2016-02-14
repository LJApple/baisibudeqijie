//
//  LJNewViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJNewViewController.h"

@interface LJNewViewController ()

@end

@implementation LJNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(newButtonClick)];
    
    // 设置背景颜色
   self.view.backgroundColor =  LJGlobalBg;
}

- (void)newButtonClick
{
    LJLogFunc;
}
@end
