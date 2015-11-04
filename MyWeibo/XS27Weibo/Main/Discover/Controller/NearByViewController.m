//
//  NearByViewController.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "NearByViewController.h"

#import "DataService.h"
#import "WeiboModel.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "WeiboDetailViewController.h"


@interface NearByViewController ()

@end

@implementation NearByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createViews];
    
    
    [self _location];
    
}

#pragma mark - 创建视图
-(void) _createViews {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    
    _mapView.userTrackingMode = YES;
    
    [self.view addSubview:_mapView];
    
    
    
    
    //测试
    //创建annotation 对象(model)
//    WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
//    annotation.title = @"Mcy";
//    CLLocationCoordinate2D coordinate = {30.330139,120.38917};
//    [annotation setCoordinate:coordinate];
//    [_mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CLLocation Delegate
- (void)_location{
    _locationManager = [[CLLocationManager alloc] init];
    
    if (kVersion > 8.0) {
        [_locationManager requestWhenInUseAuthorization];
    }
    _locationManager.desiredAccuracy =  kCLLocationAccuracyBest;
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
}


    

//更新地理位置后重新获取坐标
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //1 停止定位
    [_locationManager stopUpdatingLocation];
    
    //2 请求数据
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self _loadNearByData:lon lat:lat];
    
    
    //3 设置地图显示区域
    
    CLLocationCoordinate2D center = coordinate;
    //数值越小,显示范围越小
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
    
}



#pragma mark - 获取附近微博
- (void)_loadNearByData:(NSString *)lon lat:(NSString *)lat{
    
    
    //修改 AFNetWorking 支持 text/html  AFURLResponseSerialization.m中
    //self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        
        NSMutableArray *annotationArray = [[ NSMutableArray alloc] initWithCapacity:statuses.count];
        
        
        for (NSDictionary *dataDic in statuses) {
            
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
            
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
            annotation.model = model;
            
            [annotationArray addObject:annotation];
            
            
        }
        
        [_mapView addAnnotations:annotationArray];
        
    }];
    
}



//#pragma mark 一 大头针  实现协议方法，返回标注视图
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
//    //MKUserLocation  用户当前位置的类
//    //如果是用户的位置，则使用默认的标注视图
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//
//
//    //复用池，得到 大头针标注视图
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
//
//    if (pinView == nil) {
//        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
//
//        //1  设置大头针颜色
//        pinView.pinColor = MKPinAnnotationColorGreen;
//
//        //2  从天而降动画
//        pinView.animatesDrop = YES;
//
//        //3 设置显示标题
//        pinView.canShowCallout = YES;
//        
//        //添加辅助视图
//        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    }
//    return pinView;
//}




// 二 项目中 微博标注视图（自定义） 创建
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    //得到标注视图
    WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    
    if (annotationView == nil) {
        annotationView = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    
    annotationView.annotation = annotation;
    return annotationView;
    
    
}


//选中标注视图的协议方法
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    // return;
    
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    WeiboDetailViewController *detailVC = [[WeiboDetailViewController alloc] init];
    
    WeiboAnnotation *annoation = (WeiboAnnotation *)view.annotation;
    
    detailVC.weiboModel = annoation.model;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}



@end
