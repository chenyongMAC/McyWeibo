//
//  AppDelegate.h
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "Common.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  SinaWeibo *sinaWeibo;


@end

