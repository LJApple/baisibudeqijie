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
@property (nonatomic, assign) NSInteger ID;

/** 总数*/
@property (nonatomic, assign) NSInteger  count;

/** 名字*/
@property (nonatomic, copy) NSString * name;

/** 这个类别对应的用户啊数据*/
@property (nonatomic, strong) NSMutableArray * users;

/** 总数*/
@property (nonatomic, assign) NSInteger  total;

/** 当前页码*/
@property (nonatomic, assign) NSInteger  currentPage;


@end
