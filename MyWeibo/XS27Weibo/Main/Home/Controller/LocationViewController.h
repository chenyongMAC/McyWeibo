//
//  LocationViewController.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PoiModel.h"

@interface LocationViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate> {
    UITableView *_tableView;
    CLLocationManager *_locationManager;
}

@property (nonatomic, strong) NSArray *dataList;

@end
