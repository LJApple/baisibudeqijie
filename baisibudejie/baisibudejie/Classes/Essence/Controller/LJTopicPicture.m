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
#import "LJProgressView.h"
#import "LJShowPictureViewController.h"


@interface LJTopicPicture ()
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/** gif图片*/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮*/
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

@property (weak, nonatomic) IBOutlet LJProgressView *progressView;

@end

@implementation LJTopicPicture

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    // 给图片添加监听器
    self.iconView.userInteractionEnabled = YES;
    [self.iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    LJLogFunc;
    LJShowPictureViewController *showPicture = [[LJShowPictureViewController alloc] init];
    
    // 加载数据
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
- (void)setTopic:(LJTopics *)topic
{
    _topic = topic;
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    // 设置图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    /**
     * 取出图片的第一个字节（存储类型）sd_webImage就是，就可以判断真实的类型（最准确）
     */
    
    // 判断是否是gif
    NSString *extension = topic.largeImage.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    // 判断是否显示点击查看
    if (topic.isAutoNumberImage) {
        self.seeBigButton.hidden = NO;
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.seeBigButton.hidden = YES;
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
}
@end
