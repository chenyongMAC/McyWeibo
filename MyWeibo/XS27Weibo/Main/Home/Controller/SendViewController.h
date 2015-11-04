//
//  SendViewController.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//
#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>
#import "FaceScrollView.h"

@interface SendViewController : BaseViewController <UIActionSheetDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZoomImageViewDelegate,CLLocationManagerDelegate, FaceViewDelegate> {
    //1.文本编辑栏
    UITextView *_textView;
    
    //2.工具栏
    UIView *_editorBar;
    
    //3.图片
    ZoomImageView *_zoomImageView;
   
    
    //4.地理位置管理器
    CLLocationManager *_locationManager;
    UILabel *_locationLabel;
    
    //5.表情
    FaceScrollView *_faceViewPanel;

}


@end
