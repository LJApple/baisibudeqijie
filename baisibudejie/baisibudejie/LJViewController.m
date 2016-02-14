//
//  LJViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJViewController.h"

@interface LJViewController ()

@end

@implementation LJViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加子控制器
    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.view.backgroundColor = [UIColor redColor];
    vc01.tabBarItem.title = @"精华";
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    // 设置字体
    NSMutableDictionary *selectAtrr = [NSMutableDictionary dictionary];
    selectAtrr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtrr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc01.tabBarItem setTitleTextAttributes:selectAtrr forState:UIControlStateSelected];
    
    [self addChildViewController:vc01];
    
    UIViewController *vc02 = [[UIViewController alloc] init];
    vc02.view.backgroundColor = [UIColor blueColor];
    vc02.tabBarItem.title = @"新帖";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [vc02.tabBarItem setTitleTextAttributes:selectAtrr forState:UIControlStateSelected];

    [self addChildViewController:vc02];
    
    
    UIViewController *vc03 = [[UIViewController alloc] init];
    vc03.view.backgroundColor = [UIColor blackColor];
    vc03.tabBarItem.title = @"关注";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [vc03.tabBarItem setTitleTextAttributes:selectAtrr forState:UIControlStateSelected];

    [self addChildViewController:vc03];
    
    UIViewController *vc04 = [[UIViewController alloc] init];
    vc04.view.backgroundColor = [UIColor greenColor];
    
    vc04.tabBarItem.title = @"我";
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [vc04.tabBarItem setTitleTextAttributes:selectAtrr forState:UIControlStateSelected];

    [self addChildViewController:vc04];

}

@end
