//
//  WeiboAnnotation.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"
#import <MapKit/MapKit.h>


@interface WeiboAnnotation : NSObject<MKAnnotation>

@property (nonatomic, strong) WeiboModel *model;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

//- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
