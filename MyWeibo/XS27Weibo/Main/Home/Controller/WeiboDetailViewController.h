//
//  WeiboDetailViewController.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboDetailView.h"
#import "WeiboModel.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"


@interface WeiboDetailViewController : BaseViewController <SinaWeiboRequestDelegate> {
    WeiboDetailView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) WeiboModel *weiboModel;

@end
