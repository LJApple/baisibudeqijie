//
//  LJUserTableViewCell.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/17.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJUserTableViewCell.h"
#import "LJUserRecomendModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LJUserTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation LJUserTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUsers:(LJUserRecomendModel *)users {
    _users = users;
    self.screenNameLabel.text = users.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", users.fans_count];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:users.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
