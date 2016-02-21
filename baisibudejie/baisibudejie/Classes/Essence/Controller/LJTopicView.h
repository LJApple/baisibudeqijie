//
//  LJTopicView.h
//  baisibudejie
//
//  Created by 吕俊 on 16/2/21.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    LJTopicTypeAll = 1,
    LJTopicTypeVideo = 41,
    LJTopicTypeVoice = 31,
    LJTopicTypePicture = 10,
    LJTopicTypeStory = 29

} LJTopicType;

@interface LJTopicView : UITableViewController

@property (nonatomic, assign) LJTopicType type;

@end
