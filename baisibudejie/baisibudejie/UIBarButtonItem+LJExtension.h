//
//  UIBarButtonItem+LJExtension.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/14.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LJExtension)
+ (instancetype)itemWithImage:(NSString *)normalImage highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end
