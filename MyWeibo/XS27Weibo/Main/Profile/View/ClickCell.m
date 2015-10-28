//
//  ClickCell.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/15.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "ClickCell.h"
#import "WeiboView.h"
#import "FollowersViewController.h"

@implementation ClickCell {
    WeiboView *_weiboView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setLayout:(WeiboViewFrameLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        _weiboView.layout = _layout;
        [self setNeedsLayout];
    }
}

-(void) layoutSubviews {
    WeiboModel *_model = _layout.model;
    
    //关注按钮
    int focusNum = [_model.userModel.friends_count intValue];
    NSString *focusCount = [NSString stringWithFormat:@"关注:%d", focusNum];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:focusCount];
    NSDictionary *dic1 = @{
                           NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
                           NSForegroundColorAttributeName : [UIColor magentaColor]
                           };
    [attrStr addAttributes:dic1 range:NSMakeRange(0, focusCount.length)];
    [_commentBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
    [_commentBtn addTarget:self action:@selector(focusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //评论按钮
    int commentNum = [_model.userModel.followers_count intValue];
    NSString *commentCount = [NSString stringWithFormat:@"评论:%d", commentNum];
    NSMutableAttributedString *attrStr_comment = [[NSMutableAttributedString alloc] initWithString:commentCount];
    [attrStr_comment addAttributes:dic1 range:NSMakeRange(0, commentCount.length)];
    [_focusBtn setAttributedTitle:attrStr_comment forState:UIControlStateNormal];
    [_focusBtn addTarget:self action:@selector(commentBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //微博数按钮
    int statuesNum = [_model.userModel.statuses_count intValue];
    NSString *statuesCount = [NSString stringWithFormat:@"微博:%d", statuesNum];
    NSMutableAttributedString *attrStr_statues = [[NSMutableAttributedString alloc] initWithString:statuesCount];
    [attrStr_statues addAttributes:dic1 range:NSMakeRange(0, statuesCount.length)];
    [_weiboBtn setAttributedTitle:attrStr_statues forState:UIControlStateNormal];
//    [_weiboBtn addTarget:self action:@selector(statuesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) focusBtnAction:(UIButton *) button {
    NSLog(@"111111111111111");
}
-(void) commentBtnAction:(UIButton *) button {
    
}
//
//-(void) statuesBtnAction:(UIButton *) button {
//    
//}

@end
