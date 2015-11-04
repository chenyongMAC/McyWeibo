//
//  LeftViewController.h
//  XS27Weibo
//
//  Created by gj on 15/10/10.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "BaseViewController.h"

@interface LeftViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_sectionTitles;
    NSArray *_rowTitles;
}

@end
