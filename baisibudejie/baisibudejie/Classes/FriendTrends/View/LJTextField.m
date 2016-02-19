//
//  LJTextField.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/19.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJTextField.h"
#import <objc/runtime.h>

static NSString *const LJPlaceholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation LJTextField

+ (void)getInvars
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = *(ivars + i);
        NSLog(@"%s", ivar_getName(ivar));
    }
    free(ivars);
}

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawAtPoint:CGPointMake(0 , 15) withAttributes:@{
//                                        NSForegroundColorAttributeName:[UIColor whiteColor],
//                                        NSFontAttributeName : self.font
//                                        }];
//}

- (void)awakeFromNib
{
    self.tintColor = self.textColor;
    //不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当文本框聚焦时就会掉用
 */
- (BOOL)becomeFirstResponder
{
    // 修改占位符颜色
    [self setValue:self.textColor forKeyPath:LJPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}
/**
 *  当文本框失去焦点时就会掉用这个方法
 *
 *  @return [super becomeFierstResponder];
 */
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:LJPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}
@end
