//
//  LJVideo.m
//  baisibudejie
//
//  Created by 吕俊 on 16/3/3.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJVideo.h"
#import <UIImageView+WebCache.h>
#import "LJTopics.h"
#import "LJShowPictureViewController.h"

@interface LJVideo ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *palyCount;
@property (weak, nonatomic) IBOutlet UILabel *playTime;

@end

@implementation LJVideo

+ (instancetype)videoView
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
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.cdn_img]];
    
    self.palyCount.text = [NSString stringWithFormat:@"%zd次播放", topic.playfcount];
    
    // 时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.playTime.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
@end
