//
//  LJEssenceViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJEssenceViewController.h"
#import "LJRecomendTagsTableViewController.h"
#import "LJAllViewController.h"
#import "LJVideoViewController.h"
#import "LJVoiceViewController.h"
#import "LJPictureViewController.h"
#import "LJStoryTellingViewController.h"
@interface LJEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic, weak)UIView *indicatorView;

@property (nonatomic, weak)UIButton *selectButton;

@property (nonatomic, weak)UIView *titleView;

@property (nonatomic, weak) UIScrollView *contentScrollView;

@end

@implementation LJEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setNavigation];
    
    // 设置内容控制器
    [self setupChildControler];
    
    // 设置顶部的标签栏
    [self setTitleView];
    
    // 设置内容的scrollView
    [self setupcontentScrollView];
    
}

/**
 *  初始化子控制器
 */
- (void)setupChildControler
{
    LJAllViewController *all = [[LJAllViewController alloc] init];
    [self addChildViewController:all];
    
    LJVideoViewController *video = [[LJVideoViewController alloc] init];
    [self addChildViewController:video];
    
    LJVoiceViewController *voice = [[LJVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    LJPictureViewController *picture = [[LJPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    LJStoryTellingViewController *story = [[LJStoryTellingViewController alloc] init];
    [self addChildViewController:story];
}

/**
 *  设置顶部标签栏
 */
- (void)setTitleView
{
    // 标签栏
    UIView *titleView = [[UIView alloc] init];
    titleView.width = self.view.width;
    titleView.height = LJTitilesViewH;
    titleView.y = LJTitilesViewY;
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
   // indicatorView.tag = -1;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的字标签
    NSArray *titles = @[@"全部内容",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width =  self.view.width / titles.count;
    CGFloat height  =titleView.height;
    for (NSUInteger i = 0; i < titles.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i;
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
    [titleView addSubview:indicatorView];
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
    
    // 滚动
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x =  self.contentScrollView.width * button.tag;
    [self.contentScrollView setContentOffset:offset animated:YES ];
  }

/**
 *  设置内容contentscrlooer
 */
- (void)setupcontentScrollView
{
    
    // 不要自动调整Insert
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    contentScrollView.frame = self.view.bounds;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    [self.view insertSubview:contentScrollView atIndex:0];
    
    contentScrollView.contentSize = CGSizeMake(contentScrollView.width * self.childViewControllers.count, 0);
    self.contentScrollView = contentScrollView;
    
    // 添加第一个控制器view
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
    
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

#pragma mark -<delegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    // 设置tableview的y值为0
    vc.view.y = 0;
    // 设置控制器的view的height时整个屏幕的高度（默认时比屏幕高少个20）
    vc.view.height = scrollView.height;
//    // 设置内边框
//    CGFloat top = CGRectGetMaxY(self.titleView.frame);
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
//    // 设置滚动条内边距
//    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self buttonClick:self.titleView.subviews[index]];
}
@end
