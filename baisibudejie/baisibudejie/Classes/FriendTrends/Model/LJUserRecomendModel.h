//
//  LJUserRecomendModel.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/17.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJUserRecomendModel : NSObject
/** url路径*/
@property (nonatomic, copy) NSString * header;
/** 粉丝数*/
@property (nonatomic, assign) NSInteger fans_count;
/** 用户名称*/
@property (nonatomic, copy) NSString * screen_name;
@end
