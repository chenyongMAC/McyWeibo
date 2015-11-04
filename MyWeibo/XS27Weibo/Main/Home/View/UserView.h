//
//  UserView.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface UserView : UIView

@property (nonatomic, strong) WeiboModel *weiboModel;


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *srcLabel;

@end
