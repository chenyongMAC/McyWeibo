//
//  PersonalCell.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/15.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "PersonalCell.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "WeiboView.h"

@implementation PersonalCell {
    WeiboView *_weiboView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    WeiboModel *_model = _layout.model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url]];

    _nickName.text = _model.userModel.screen_name;
    
    _blogURL.text = _model.userModel.url;
    
}


-(void) setLayout:(WeiboViewFrameLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        _weiboView.layout = _layout;
        [self setNeedsLayout];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
