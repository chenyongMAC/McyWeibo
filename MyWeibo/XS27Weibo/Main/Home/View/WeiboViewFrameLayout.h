//
//  WeiboViewFrameLayout.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/12.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboModel.h"

@interface WeiboViewFrameLayout : NSObject

@property (nonatomic, assign) CGRect textFrame;
@property (nonatomic, assign) CGRect srTextFrame;
@property (nonatomic, assign) CGRect bgImgFrame;
@property (nonatomic, assign) CGRect imgFrame;

@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) WeiboModel *model;

@end
