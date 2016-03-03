//
//  LJTopicPicture.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/21.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJTopics;

@interface LJTopicPicture : UIView

+ (instancetype)pictureView;

/** 将*/
@property (nonatomic, strong) LJTopics *topic;
@end
