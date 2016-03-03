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
@property (nonatomic, copy) NSString * smallImage;
/** 大图*/
@property (nonatomic, copy) NSString * largeImage;
/** 中图*/
@property (nonatomic, copy) NSString * middleImage;
/** 图片的高度*/
@property (nonatomic, assign) CGFloat  height;
/** 图片的宽度*/
@property (nonatomic, assign) CGFloat  width;
/** 帖子类型属性*/
@property (nonatomic, assign) LJTopicType type;

/** 声音音频长度*/
@property (nonatomic, assign) NSInteger voicetime;
/** 声音的播放次数*/
@property (nonatomic, assign) NSInteger playcount;
/** 视频加载时静态的地址*/
@property (nonatomic, copy) NSString * cdn_img;
/** 视频播放的次数*/
@property (nonatomic, assign) NSInteger playfcount;
/** 视频播放的长度*/
@property (nonatomic, assign) NSInteger videotime;



/** 其它类型属性*/
/** cell的高度*/
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片的frame*/
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 是否超过规定的长度*/
@property (nonatomic, assign, getter=isAutoNumberImage) BOOL  autoNumberImage;
/** 图片下载进度*/
@property (nonatomic, assign) CGFloat  pictureProgress;

/** 声音的Frame*/
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频的frame*/
@property (nonatomic, assign, readonly) CGRect videoF;


@end
