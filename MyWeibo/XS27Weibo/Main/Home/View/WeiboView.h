//
//  WeiboView.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/12.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "WeiboModel.h"
#import "WeiboViewFrameLayout.h"
#import "WXLabel.h"
#import "ZoomImageView.h"

@interface WeiboView : UIView <WXLabelDelegate>

@property (nonatomic, strong) WXLabel *textLabel;
@property (nonatomic, strong) WXLabel *sourceLabel;
@property (nonatomic, strong) ZoomImageView *imgView;
@property (nonatomic, strong) ThemeImageView *bgImgView;

//@property (nonatomic, strong) WeiboModel *model;
@property (nonatomic, strong) WeiboViewFrameLayout *layout;



@end
