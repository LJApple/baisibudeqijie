//
//  LJCategoryTableViewCell.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/16.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJCategoryTableViewCell.h"
#import "LJRecommentCategory.h"

@interface LJCategoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end

@implementation LJCategoryTableViewCell

- (void)awakeFromNib {
    
    self.backgroundColor = LJRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor =  LJRGBColor(195,72, 76);
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : LJRGBColor(110, 110, 110);
}
@end
