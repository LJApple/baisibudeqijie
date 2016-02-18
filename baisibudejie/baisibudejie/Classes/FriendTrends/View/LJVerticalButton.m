//
//  LJVerticalButton.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/18.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJVerticalButton.h"

@implementation LJVerticalButton

- (void) setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)awakeFromNib
{
    [self setUp];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
    
    // 调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}
@end
