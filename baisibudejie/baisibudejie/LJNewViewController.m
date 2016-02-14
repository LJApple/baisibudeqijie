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
    
    UIButton *newTagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newTagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [newTagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    
    newTagButton.size = newTagButton.currentBackgroundImage.size;
    
    [newTagButton addTarget:self action:@selector(newTagButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:newTagButton];
}

- (void)newTagButton
{
    LJLogFunc;
}
@end
