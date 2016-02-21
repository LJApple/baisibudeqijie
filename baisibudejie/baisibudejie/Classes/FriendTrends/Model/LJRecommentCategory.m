//
//  LJRecommentCategory.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/16.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJRecommentCategory.h"

@implementation LJRecommentCategory

- (NSMutableArray *)users
{
    if (!_users) {
         _users = [NSMutableArray array];
    }
   return _users;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
