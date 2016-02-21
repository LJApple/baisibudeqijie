//
//  NSDate+LJExtension.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LJExtension)

- (NSDateComponents *)compareTimeFrom : (NSDate *)from;

- (BOOL)isThisYear;
- (BOOL)isThisDay;
- (BOOL)isYesterDay;
@end
