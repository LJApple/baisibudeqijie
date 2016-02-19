//
//  LJEssenceViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJEssenceViewController.h"
#import "LJRecomendTagsTableViewController.h"

@interface LJEssenceViewController ()

@property (nonatomic, weak)UIView *indicatorView;

@property (nonatomic, weak)UIButton *selectButton;
@end

@implementation LJEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNavigation];
    
    // 设置顶部的标签栏
    [self setTitleView];
}

- (void)setTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.width = self.view.width;
    titleView.height = 35;
    titleView.y = 64;
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    // 创建底部导航
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部的字标签
    NSArray *titles = @[@"全部内容",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width =  self.view.width / titles.count;
    CGFloat height  =titleView.height;
    for (NSUInteger i = 0; i < titles.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        // 强制布局(强制更新子控件的frame)
       // [button layoutIfNeeded];
        
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        // 这样的话标签会被重复点击
        //[button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleView addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 默认选中
        if (i == 0) {
            // 显示
            button.enabled = NO;
            self.selectButton = button;
            
            // 让按钮内部的labe根据文字内容计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }

    }
}

- (void)buttonClick:(UIButton *)button
{
   // 修改按钮状态
//    self.selectButton.selected = NO;
//    button.selected = YES;
//    self.selectButton = button;
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{

        self.indicatorView.width = button.titleLabel.width;
        
        self.indicatorView.centerX = button.centerX;
        
    }];
  }
/**
 *  设置导航栏
 */
- (void)setNavigation
{
    
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(essenceButtonClick)];
    
    // 设置背景颜色
    self.view.backgroundColor =  LJGlobalBg;

}

- (void)essenceButtonClick
{
    LJRecomendTagsTableViewController *vc = [[LJRecomendTagsTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
