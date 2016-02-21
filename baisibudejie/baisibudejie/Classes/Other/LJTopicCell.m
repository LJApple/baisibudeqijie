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

@interface LJTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLael;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;

@end

@implementation LJTopicCell

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
    static NSInteger margin = 10;
    
    frame.origin.x = margin;
    frame.origin.y += margin;
    
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    
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
}
@end
