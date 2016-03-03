//
//  LJVideo.h
//  baisibudejie
//
//  Created by 吕俊 on 16/3/3.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJTopics;

@interface LJVideo : UIView

+ (instancetype)videoView;

@property (nonatomic, strong) LJTopics *topic;

@end
