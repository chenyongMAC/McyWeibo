//
//  NearByViewController.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h> 
#import <MapKit/MapKit.h>

@interface NearByViewController : BaseViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}

@end
