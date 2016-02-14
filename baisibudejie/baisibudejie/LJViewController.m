//
//  LJViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJViewController.h"
#import "LJEssenceViewController.h"
#import "LJNewViewController.h"
#import "LJFriendTrendsViewController.h"
#import "LJMeViewController.h"
#import "LJTabBar.h"

@interface LJViewController ()

@end

@implementation LJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置字体
    NSMutableDictionary *selectAtrr = [NSMutableDictionary dictionary];
    selectAtrr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAtrr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    // 利用appearance统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:selectAtrr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAtrr forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[LJEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[LJNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[LJFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[LJMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 更换tabar
    [self setValue:[[LJTabBar alloc] init] forKey:@"tabBar"];
    
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    vc.navigationItem.title = title;
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    [self addChildViewController:vc];
    
    // 包装一个导航控制器，添加导航控制为tabbarController的子控制器
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navigation];
}
@end
