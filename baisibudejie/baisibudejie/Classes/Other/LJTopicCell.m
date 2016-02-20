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

@end

@implementation LJTopicCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setFrame:(CGRect)frame
{
    static NSInteger margin = 10;
    
    frame.origin.x = margin;
    frame.origin.y += margin;
    
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}
- (void)setTopics:(LJTopics *)topics
{
    _topics = topics;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topics.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLael.text = topics.name;
    self.timeLabel.text = topics.create_time;
    
    // 设置底部按钮
    [self setButtonTitle:self.dingButton number:topics.ding title:@"顶"];
    [self setButtonTitle:self.caiButton number:topics.cai title:@"踩"];
    [self setButtonTitle:self.shareButton number:topics.repost title:@"分享"];
    [self setButtonTitle:self.commentButton number:topics.comment title:@"评论"];
}

- (void)setButtonTitle : (UIButton *)button number : (NSInteger)number title: (NSString *)title
{

    if ( number> 10000) {
        title = [NSString stringWithFormat:@"%.1f万", number / 10000.0];
    } else  if (number > 0){
        title = [NSString stringWithFormat:@"%zd", number];
    } 
    [button setTitle:title forState:UIControlStateNormal];
}
@end
