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
/** 是否是新浪注册用户*/
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v ;
/** 小图*/
@property (nonatomic, strong) NSString * smallImage;
/** 大图*/
@property (nonatomic, strong) NSString * largeImage;
/** 中图*/
@property (nonatomic, strong) NSString * middleImage;
/** 图片的高度*/
@property (nonatomic, assign) NSInteger  height;
/** 图片的宽度*/
@property (nonatomic, assign) NSInteger  width;




/** cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
