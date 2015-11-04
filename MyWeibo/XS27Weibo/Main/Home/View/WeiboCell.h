//
//  WeiboCell.h
//  XS27Weibo
//
//  Created by gj on 15/10/12.
//  Copyright (c) 2015年 mac All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WeiboModel.h"
#import "WeiboViewFrameLayout.h"

@interface WeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rePostLabel;
@property (weak, nonatomic) IBOutlet UILabel *srcLabel;
@property (strong, nonatomic) IBOutlet UILabel *pralseLabel;


//@property (nonatomic,strong) WeiboModel *model;
@property (nonatomic, strong) WeiboViewFrameLayout *layout;


@end
