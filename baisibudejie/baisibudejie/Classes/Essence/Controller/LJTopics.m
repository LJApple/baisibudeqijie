//
//  LJTopics.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/20.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJTopics.h"
// #import <MJExtension.h>

@implementation LJTopics
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

- (NSString *)create_time
{
    /**
     今年
     今天
     1分钟内
     刚刚
     1小时内
     xx分钟前
     其他
     xx小时前
     昨天
     昨天 18:56:34
     其他
     06-23 19:56:23
     
     非今年
     2014-05-08 18:45:30
     */

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {
        if (create.isThisDay) {
            NSDateComponents *cmps = [[NSDate date] compareTimeFrom:create];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }  else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if (create.isYesterDay) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else {
        return  _create_time;
    }
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"smallImage":@"image0",
             @"largeImage":@"image1",
             @"middleImage":@"image2"
             };
}

//+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName
//{
//    if ([propertyName isEqualToString:@"smallImage"]) {
//        return @"small_image";
//    }
//    return propertyName;
//}
- (CGFloat)cellHeight
{
    if (!_cellHeight) {
       
       
        // 文字最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LJTopicMarigin, MAXFLOAT) ;
        // 计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        
        // 计算图片的高度
        _cellHeight = LJTopicCellTextY + textH + LJTopicCellBottomH + 2 * LJTopicMarigin;
        
        // 根据类型计算图片的高度
        if (self.type == LJTopicTypePicture) {
            CGFloat pictureW = maxSize.width;
            CGFloat pictureH = pictureW * self.height / self.width;
            _cellHeight += pictureH + LJTopicMarigin;
            
            CGFloat pictureX = LJTopicMarigin;
            CGFloat pictureY = LJTopicCellTextY + textH + LJTopicMarigin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        }
}
    return _cellHeight;
}
@end
