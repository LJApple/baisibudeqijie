//
//  LJRecomendTags.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/17.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJRecomendTags : NSObject
/** 图片路径*/
@property (nonatomic, copy) NSString * image_list;

/** 订阅数*/
@property (nonatomic, assign) NSInteger  sub_number;

/** 主题名*/
@property (nonatomic, copy) NSString * theme_name;

@end
