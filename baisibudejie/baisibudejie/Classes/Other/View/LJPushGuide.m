//
//  LJPushGuide.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/19.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJPushGuide.h"

@implementation LJPushGuide


- (void)awakeFromNib
{
    
    UIButton *button = [[UIButton alloc] init];
    
    [self addSubview:button];
}

+ (instancetype)pushGuide
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LJPushGuide" owner:nil options:nil] lastObject];
}

+ (void)showPushguide
{
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中的存储版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LJPushGuide *pushGuide = [LJPushGuide pushGuide];
        pushGuide.frame = window.bounds;
        [window addSubview:pushGuide];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

- (IBAction)close {
    [self removeFromSuperview];
}
@end
