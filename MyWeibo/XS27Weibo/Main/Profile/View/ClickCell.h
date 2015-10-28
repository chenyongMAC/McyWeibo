//
//  ClickCell.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/15.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"

@interface ClickCell : UITableViewCell

//@property (strong, nonatomic) WeiboModel *model;
@property (strong, nonatomic) WeiboViewFrameLayout *layout;

@property (strong, nonatomic) IBOutlet UIButton *weiboBtn;
@property (strong, nonatomic) IBOutlet UIButton *focusBtn;
@property (strong, nonatomic) IBOutlet UIButton *commentBtn;

@end
