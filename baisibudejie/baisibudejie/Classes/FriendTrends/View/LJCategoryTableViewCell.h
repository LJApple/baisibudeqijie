//
//  LJCategoryTableViewCell.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/16.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJRecommentCategory;
@interface LJCategoryTableViewCell : UITableViewCell

/** 类别*/
@property (nonatomic, strong) LJRecommentCategory * category;
@end
