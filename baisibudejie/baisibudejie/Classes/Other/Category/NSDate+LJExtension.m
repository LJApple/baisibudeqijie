//
//  NSDate+LJExtension.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "NSDate+LJExtension.h"

@implementation NSDate (LJExtension)

- (NSDateComponents *)compareTimeFrom : (NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    // 比较时间
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger thisYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == thisYear;
}
- (BOOL)isThisDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
  NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return nowCmps.year == selfCmps.year
    && nowCmps.month == selfCmps.month
    && nowCmps.day == selfCmps.day;
}

- (BOOL)isYesterDay
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *candlenar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ;
    
    NSDateComponents *cmps = [candlenar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
        &&cmps.month == 0
        &&cmps.day ==1;
}
@end
