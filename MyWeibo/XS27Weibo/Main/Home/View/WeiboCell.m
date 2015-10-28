//
//  WeiboCell.m
//  XS27Weibo
//
//  Created by gj on 15/10/12.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "WeiboView.h"
#import "UserModel.h"

@implementation WeiboCell {
    WeiboView *_weiboView;
}

- (void)awakeFromNib {
    // Initialization code
    
    [self _createSubView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

-(void) setLayout:(WeiboViewFrameLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        _weiboView.layout = _layout;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    WeiboModel *_model = _layout.model;
    
    //01 头像
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.userModel.profile_image_url]];
    //02 昵称
    _nickNameLabel.text = _model.userModel.screen_name;
    //03 评论
    NSString *commentCount = [_model.commentsCount stringValue];
    _commentLabel.text = [NSString stringWithFormat:@"评论:%@",commentCount];
    
    //04 转发
    NSString *repostCount = [_model.repostsCount stringValue];
    _rePostLabel.text = [NSString stringWithFormat:@"转发:%@",repostCount];
    
    //05 来源
    _srcLabel.text = _model.source;
    
    //06
    _weiboView.frame = _layout.frame;
}

-(void) _createSubView {
    _weiboView = [[WeiboView alloc] init];
    
    [self.contentView addSubview:_weiboView];
}

@end
