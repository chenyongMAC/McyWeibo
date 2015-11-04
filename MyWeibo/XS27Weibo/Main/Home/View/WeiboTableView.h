//
//  WeiboTableView.h
//  XS27Weibo
//
//  Created by gj on 15/10/12.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *data;
@end
