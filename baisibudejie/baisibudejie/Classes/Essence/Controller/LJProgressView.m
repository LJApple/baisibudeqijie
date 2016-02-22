//
//  LJProgressView.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/21.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJProgressView.h"
@implementation LJProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 10;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", progress * 100];

}
@end
