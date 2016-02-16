//
//  LJCategoryTableViewCell.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/16.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJCategoryTableViewCell.h"
#import "LJRecommentCategory.h"

@implementation LJCategoryTableViewCell

- (void)awakeFromNib {
    
    self.backgroundColor = LJRGBColor(244, 244, 244);
}

- (void)setCategory:(LJRecommentCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 4;
}
@end
