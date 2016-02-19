//
//  LJLoginRigsterViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/18.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJLoginRigsterViewController.h"

@interface LJLoginRigsterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *placeHolder;

@end

@implementation LJLoginRigsterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
    [attr setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 3)];
    self.placeHolder.attributedPlaceholder = attr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  让当前控制器对应的状态栏是白色的
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
