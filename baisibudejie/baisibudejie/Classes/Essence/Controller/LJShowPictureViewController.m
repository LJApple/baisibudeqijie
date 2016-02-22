//
//  LJShowPictureViewController.m
//  baisibudejie
//
//  Created by 吕俊 on 16/2/22.
//  Copyright © 2016年 吕俊. All rights reserved.
//

#import "LJShowPictureViewController.h"
#import "LJTopics.h"
#import  <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "LJProgressView.h"

@interface LJShowPictureViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet LJProgressView *pictureClickProgress;

@end

@implementation LJShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    // 添加手势
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    
    // 屏幕尺寸
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 图片尺寸
    CGFloat pictureW = screenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    
    if (pictureH > screenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = screenH * 0.5;
    }
    
    // 加载数据
    [self.pictureClickProgress setProgress:self.topic.pictureProgress animated:YES];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.pictureClickProgress.hidden = NO;
        [self.pictureClickProgress setProgress:1.0 * receivedSize/ expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.pictureClickProgress.hidden = YES;
    }];
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存成功"];
    }
}
@end
