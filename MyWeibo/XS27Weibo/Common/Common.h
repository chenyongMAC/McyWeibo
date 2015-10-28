//
//  Common.h
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#ifndef XS27Weibo_Common_h
#define XS27Weibo_Common_h


//系统版本
#define   kVersion   [[UIDevice currentDevice].systemVersion floatValue]
#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height


#define kAppKey             @"396693043"
#define kAppSecret          @"88736f02202a34561981f3bfbf7b771e"
//#define kAppRedirectURI     @"http://www.baidu.com"
#define kAppRedirectURI     @"https://api.weibo.com/oauth2/default.html"


#define unread_count  @"remind/unread_count.json"
#define home_timeline @"statuses/home_timeline.json"
#define comments      @"comments/show.json"
#define send_update @"statuses/update.json"  //发微博(不带图片)
#define send_upload @"statuses/upload.json"  //发微博(带图片)

#define geo_to_address @"location/geo/geo_to_address.json"  //查询坐标对应的位置
#define nearby_pois @"place/nearby/pois.json" // 附近商圈
#define nearby_timeline  @"place/nearby_timeline.json" //附近动态


#define kPullRefresh @"kPullRefresh"

#endif
