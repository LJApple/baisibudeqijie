//
//  UIButton+LJExtension.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/21.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "UIButton+LJExtension.h"

@implementation UIButton (LJExtension)


- (void)setButtonTitle : (NSInteger)count title:(NSString *)title
{
    if ( count > 10000) {
        title = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else  if (count > 0){
        title = [NSString stringWithFormat:@"%zd", count];
    }
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}

@end
