//
//  CommentCell.h
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DetailModel.h"
#import "WXLabel.h"

@interface CommentCell : UITableViewCell <WXLabelDelegate> {
    WXLabel *_commentTextLabel;
}


@property (strong, nonatomic) IBOutlet UIImageView *userImg;//
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, retain) DetailModel *detailModel;

+ (float)getCommentHeight:(DetailModel *)detailModel ;

@end
