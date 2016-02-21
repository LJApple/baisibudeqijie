//
//  LJTopicPicture.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/21.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJTopicPicture.h"
#import "LJTopics.h"
#import <UIImageView+WebCache.h>

@interface LJTopicPicture ()
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** gif图片*/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮*/
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@end

@implementation LJTopicPicture

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(LJTopics *)topic
{
    _topic = topic;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
}
@end
