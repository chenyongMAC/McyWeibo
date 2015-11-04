//
//  WeiboAnnotation.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation


- (void)setModel:(WeiboModel *)weiboModel{
    _model = weiboModel;
    NSDictionary *geo = weiboModel.geo;
    
    
    NSArray *coordinates = [geo objectForKey:@"coordinates"];
    if (coordinates.count >= 2) {
        
        NSString *longitude = coordinates[0];
        NSString *latitude = coordinates[1];
        
        _coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
    }
    
}

@end
