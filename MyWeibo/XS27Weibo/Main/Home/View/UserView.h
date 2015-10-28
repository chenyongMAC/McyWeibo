//
//  UserView.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface UserView : UIView

@property (nonatomic, strong) WeiboModel *weiboModel;


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *srcLabel;

@end
