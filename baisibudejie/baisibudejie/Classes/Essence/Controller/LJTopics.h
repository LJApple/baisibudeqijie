//
//  LJTopics.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJTopics : NSObject


/** 用户的name*/
@property (nonatomic, strong) NSString * name;

/** 图片*/
@property (nonatomic, strong) NSString * profile_image;
/** 创建时间*/
@property (nonatomic, strong) NSString * create_time;
/** 内容*/
@property (nonatomic, strong) NSString * text;
/** 顶的数量*/
@property (nonatomic, assign) NSInteger  ding;
/** 踩的数量*/
@property (nonatomic, assign) NSInteger  cai;
/** 转发的数量*/
@property (nonatomic, assign) NSInteger  repost;
/** 评论的数量*/
@property (nonatomic, assign) NSInteger  comment;

@end
