//
//  NearByViewController.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h> 
#import <MapKit/MapKit.h>

@interface NearByViewController : BaseViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}

@end
