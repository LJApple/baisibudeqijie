//
//  LJRecommentCategory.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/16.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJRecommentCategory : NSObject


/** id*/
@property (nonatomic, assign) NSInteger id;

/** 总数*/
@property (nonatomic, assign) NSInteger  count;

/** 名字*/
@property (nonatomic, copy) NSString * name;

/** 右边数据的用户组*/
@property (nonatomic, strong) NSMutableArray * users;
@end
