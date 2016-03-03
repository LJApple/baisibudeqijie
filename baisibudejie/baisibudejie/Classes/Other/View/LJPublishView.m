//
//  LJPublishView.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/23.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJPublishView.h"
#import "LJVerticalButton.h"
#import <POP.h>

//#define LJRootViewClick [UIApplication sharedApplication].keyWindow.rootViewController.view
@implementation LJPublishView

static UIWindow *_window;
+ (void)show
{
  //创建窗口
    _window = [[UIWindow alloc] init];
    _window.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    _window.frame = [UIScreen mainScreen].bounds;
    _window.hidden = NO;
    
    // 将publish添加到window上
    LJPublishView * publishView = [LJPublishView publishView];
    publishView.frame = _window.bounds;
    [_window addSubview:publishView];
}

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
   //  LJRootViewClick.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    NSInteger column = 3;
    CGFloat startX = 15;
    CGFloat startY = (LJScreenH - 2 * buttonH) * 0.5;
    CGFloat marginX = (LJScreenW - 2 * startX - column * buttonW) / (column - 1);
    for (int  i = 0; i < images.count; i++) {
        LJVerticalButton *button = [[LJVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self addSubview:button];

        // 设置frame
        button.width = buttonW;
        button.height = buttonH;
        NSInteger col = i % column;
        NSInteger row = i / column;
        CGFloat buttonX = startX + col * (buttonW + marginX);
        CGFloat buttonEndY = startY + row * buttonH;
        CGFloat buttonBeginX = buttonX - LJScreenW;
        CGFloat buttonBeginY = buttonEndY - LJScreenH;
        
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.fromValue  = [NSValue valueWithCGRect:CGRectMake(buttonBeginX, buttonBeginY, buttonW, buttonH)];
        anim.toValue  = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 设置app_slogan
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    CGFloat aloganViewX = LJScreenW * 0.5;
    CGFloat aloganViewEndY = LJScreenH * 0.2;
    CGFloat aloganViewBeginX = aloganViewEndY - LJScreenH;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(aloganViewX, aloganViewBeginX)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(aloganViewX, aloganViewEndY)];
    [sloganView pop_addAnimation:anim forKey:nil];
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // LJRootViewClick.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }];
}

-(void)buttonClick:(UIButton *)button
{
    [self cancleWithComletionBlock:^{
        if (button.tag == 0) {
            NSLog(@"发视频");
        }

    }];
}


- (void)cancleWithComletionBlock:(void(^)())completionBlock
{
    self.userInteractionEnabled = NO;
    int beginIndex = 1;
    for (int i = beginIndex; i < self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + LJScreenH;
        anim.beginTime = CACurrentMediaTime() + 0.08 * (i - beginIndex);
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        [subView pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
               // LJRootViewClick.userInteractionEnabled = YES;
                //               [self removeFromSuperview];
                // 销毁窗口
                _window.hidden = YES;
                // 执行传进来的参数
                !completionBlock ? : completionBlock();
            }];
            
        }
    }
}

- (IBAction)cancle {
    [self cancleWithComletionBlock:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancleWithComletionBlock:nil];
}
@end
