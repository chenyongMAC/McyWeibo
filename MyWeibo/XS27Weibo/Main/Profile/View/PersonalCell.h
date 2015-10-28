//
//  PersonalCell.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/15.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"
#import "WeiboModel.h"

@interface PersonalCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *blogURL;

//@property (strong, nonatomic) WeiboModel *model;
@property (strong, nonatomic) WeiboViewFrameLayout *layout;

@end
