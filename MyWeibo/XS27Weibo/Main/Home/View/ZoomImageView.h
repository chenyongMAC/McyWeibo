//
//  ZoomImageView.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoomImageView;

@protocol ZoomImageViewDelegate <NSObject>
@optional

//图片将要点击放大
-(void) imageWillZoomIn:(ZoomImageView *)imageView;

//图片将要点击缩小
-(void) imageWillZoomOut:(ZoomImageView *)imageView;

@end

@interface ZoomImageView : UIImageView <NSURLConnectionDelegate, NSURLConnectionDataDelegate, UIAlertViewDelegate> {
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
}



@property (nonatomic, copy) NSString *fullImageString;

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, assign) BOOL isGif;

@property (nonatomic, weak)id<ZoomImageViewDelegate> delegate;

@end
