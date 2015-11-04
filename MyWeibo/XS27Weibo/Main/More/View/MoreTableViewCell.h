//
//  MoreTableViewCell.h
//  HWWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "ThemeImageView.h"

@interface MoreTableViewCell : UITableViewCell

//为了实现 主题的切换
@property (nonatomic, strong) ThemeImageView *themeImageView;
@property (nonatomic, strong) ThemeLabel *themeTextLabel;
@property (nonatomic, strong) ThemeLabel *themeDetailLabel;
@property (nonatomic, strong) ThemeLabel *themeUserIDLabel;

@end
