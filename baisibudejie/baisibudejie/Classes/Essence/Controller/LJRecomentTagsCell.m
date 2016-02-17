//
//  LJRecomentTagsCell.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/17.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJRecomentTagsCell.h"
#import "LJRecomendTags.h"
#import <UIImageView+WebCache.h>

@interface LJRecomentTagsCell ()

@property (weak, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageTagView;
@property (weak, nonatomic) IBOutlet UILabel *sub_numberLabel;
@end

@implementation LJRecomentTagsCell

- (void)setRecomendTags:(LJRecomendTags *)recomendTags
{
    _recomendTags = recomendTags;
    self.theme_nameLabel.text = recomendTags.theme_name;
    
    NSString *subNumber = nil;
    if (recomendTags.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"已有%zd订阅", recomendTags.sub_number];
    } else {
        subNumber = [NSString stringWithFormat:@"已有%zd万订阅", recomendTags.sub_number / 10000];
    }
    self.sub_numberLabel.text = subNumber;
    
    [self.imageTagView sd_setImageWithURL:[NSURL URLWithString:recomendTags.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end
