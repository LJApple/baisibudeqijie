//
//  LJTopicVoice.m
//  baisibudejie
//
//  Created by 吕俊 on 16/3/3.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJTopicVoice.h"
#import <UIImageView+WebCache.h>
#import "LJTopics.h"
#import "LJShowPictureViewController.h"


@interface LJTopicVoice ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCounts;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;

@end

@implementation LJTopicVoice

+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone ;
    
    // 给图片添加听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)]];
}


- (void)showImage
{
    LJShowPictureViewController *showPicture =  [[LJShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(LJTopics *)topic
{
    _topic = topic;
    
    // 加载数据
    self.playCounts.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
   
    NSInteger minute = topic.voicetime / 60;

    NSInteger second = topic.voicetime % 60;
    self.timeLength.text = [NSString stringWithFormat:@"%02zd:%02zd", minute,second];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage]];
}
@end
