//
//  UserView.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "UserView.h"
#import "UIImageView+WebCache.h"

@implementation UserView

- (void)setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        [self setNeedsLayout];
    }
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    _imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _imageView.layer.borderWidth = 1;
    _imageView.layer.cornerRadius = _imageView.width/2;
    _imageView.layer.masksToBounds = YES;
    
    //1.设置头像
    NSString *imgURL = self.weiboModel.userModel.avatar_large;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgURL]];
    
    //2.设置昵称
    _nickName.text = self.weiboModel.userModel.screen_name;
    
    //3.设置来源
    _srcLabel.text = self.weiboModel.source;
    
}


@end











