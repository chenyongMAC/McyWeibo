//
//  WeiboDetailView.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UserView.h"


@interface WeiboDetailView : UITableView <UITableViewDelegate, UITableViewDataSource> {
    //创建头视图
    UIView *_headerView;
    
    //创建微博视图
    WeiboView *_weiboView;
    
    //创建用户视图
    UserView *_userView;
}

@property(nonatomic,strong)NSArray *commentDataArray;
@property(nonatomic,strong)WeiboModel *weiboModel;
@property(nonatomic,strong)NSDictionary *commentDic;

@end
