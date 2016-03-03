//
//  LJTopicCell.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJTopicCell.h"
#import "LJTopics.h"
#import <UIImageView+WebCache.h>
#import "LJTopicPicture.h"
#import "LJTopicVoice.h"
#import "LJVideo.h"

@interface LJTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLael;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;

/** cell中间的图片*/
@property (nonatomic, weak) LJTopicPicture *pictureView;
/** 声音中间的图片*/
@property (nonatomic, weak) LJTopicVoice *voiceView;
/** 视频中间的图片*/
@property (nonatomic, weak) LJVideo *videoView;

@end

@implementation LJTopicCell

/**
 *  设置懒加载防止每次都要掉用
 */
- (LJTopicPicture *)pictureView
{
    if (!_pictureView) {
        LJTopicPicture *pictureView = [LJTopicPicture pictureView];
        self.pictureView = pictureView;
        [self.contentView addSubview:pictureView];
    }
    return _pictureView;
}
- (LJTopicVoice *)voiceView
{
    if (!_voiceView) {
        LJTopicVoice *voiceView = [LJTopicVoice voiceView];
        self.voiceView = voiceView;
        [self.contentView addSubview:voiceView];
    }
    return _voiceView;
}
- (LJVideo *)videoView
{
    if (!_videoView) {
      LJVideo *videoView  =  [LJVideo videoView];
        self.videoView = videoView;
        [self.contentView addSubview:videoView];
    }
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 *  对scrolView进行调整
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = LJTopicMarigin;
    frame.origin.y += LJTopicMarigin;
    
    frame.size.width -= 2 * LJTopicMarigin;
    frame.size.height -= LJTopicMarigin;
    
    [super setFrame:frame];
}

/** 设置数据*/
- (void)setTopics:(LJTopics *)topics
{
    // 判断是否时x新浪注册
    self.sina_vImageView.hidden = !topics.isSina_v;
    
    _topics = topics;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLael.text = topics.name;
    self.timeLabel.text = topics.create_time;
    
    // 设置底部按钮
    [self.dingButton setButtonTitle:topics.ding title:@"顶"];
    [self.caiButton setButtonTitle:topics.cai title:@"踩"];
    [self.shareButton setButtonTitle:topics.repost title:@"分享"];
    [self.commentButton setButtonTitle:topics.comment title:@"评论"];
    
    // 设置帖子文字内容
    self.textContentLabel.text = topics.text;
    
    // 根据type的类型设置图片数据
    if (topics.type == LJTopicTypePicture) {
        self.pictureView.hidden = NO;
        // 加载图片到cell中
        self.pictureView.topic = topics;
        // 设置图片的frame,将picture的frame设置成topics的一个属性,在在设置高度的时候一起设置
        self.pictureView.frame = topics.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topics.type == LJTopicTypeVoice)
    {
        self.videoView.hidden = NO;
        // 加载图片到cell中
        self.voiceView.topic = topics;
        // 设置图片的frame，
        self.voiceView.frame = topics.voiceF;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (topics.type == LJTopicTypeVideo) {
        self.videoView.hidden = NO;
        self.videoView.topic = topics;
        self.videoView.frame = topics.voiceF;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
    } else {// 段子帖子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
}
@end
