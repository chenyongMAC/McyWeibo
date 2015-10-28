//
//  HomeViewController.h
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"
#import "ThemeLabel.h"
#import "WeiboTableView.h"
#import "SinaWeiboRequest.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate> 

@property (nonatomic, strong) NSMutableArray *data;

@end
