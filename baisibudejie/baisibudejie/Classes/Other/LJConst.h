
#import <UIKit/UIKit.h>

typedef enum  {
    LJTopicTypeAll = 1,
    LJTopicTypeVideo = 41,
    LJTopicTypeVoice = 31,
    LJTopicTypePicture = 10,
    LJTopicTypeStory = 29
    
} LJTopicType;

/** 顶部导航条的高度*/
UIKIT_EXTERN CGFloat const LJTitilesViewH;
/** 顶部导航条Y值*/
UIKIT_EXTERN CGFloat const LJTitilesViewY;

/** topic的间隙*/
UIKIT_EXTERN CGFloat const LJTopicMarigin;
/** cell底部的导航条的高度*/
UIKIT_EXTERN CGFloat const LJTopicCellBottomH;
/** 用户文字的Y*/
UIKIT_EXTERN CGFloat const LJTopicCellTextY;

/** 精华帖子中的最大高度*/
UIKIT_EXTERN CGFloat const LJTopicCellPictureH;
/** 精华－帖子超过后这是的高度*/
UIKIT_EXTERN CGFloat const LJTopicCellImageH;