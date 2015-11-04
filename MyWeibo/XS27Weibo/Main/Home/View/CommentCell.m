//
//  CommentCell.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "ThemeManager.h"

@implementation CommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        _commentTextLabel = [[WXLabel alloc] initWithFrame:CGRectZero];
        _commentTextLabel.font = [UIFont systemFontOfSize:14.0f];
        _commentTextLabel.linespace = 5;
        _commentTextLabel.wxLabelDelegate = self;
        [self.contentView addSubview:_commentTextLabel];
    }
    
    return self;
}

-(void) setDetailModel:(DetailModel *)detailModel {
    if (_detailModel != detailModel) {
        _detailModel = detailModel;
        [self setNeedsLayout];
    }
}


-(void) layoutSubviews {
    [super layoutSubviews];
    
    //1.头像
    NSString *urlString = _detailModel.user.profile_image_url;
    [_userImg sd_setImageWithURL:[NSURL URLWithString:urlString]];
//    _userImg.image = [UIImage imageNamed:@"icon"];
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"icon"]];
    //2.昵称
    _nameLabel.text = _detailModel.user.screen_name;
    
    //3.评论内容
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:240
                                       text:_detailModel.text
                                  linespace:5];
    //设置评论frame
    _commentTextLabel.frame = CGRectMake(_userImg.right+10, _nameLabel.bottom+5, kScreenWidth-70, height);
    //设置评论内容
    _commentTextLabel.text = _detailModel.text;
    
}

#pragma mark - WXLabel Delegate
//返回一个正则表达式，通过此正则表达式查找出需要添加超链接的文本
- (NSString *)contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加连接的字符串的正则表达式：@用户、http://... 、 #话题#
    NSString *regex1 = @"@\\w+"; //@"@[_$]";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#^#+#";  //\w 匹配字母或数字或下划线或汉字
    
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    
    return regex;
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithWXLabel:(WXLabel *)wxLabel {
    
    UIColor *linkColor = [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
    return linkColor;
}

//设置当前文本手指经过的颜色
- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel {
    return [UIColor darkGrayColor];
}


//计算评论单元格的高度
+ (float)getCommentHeight:(DetailModel *)detailModel {
    CGFloat height = [WXLabel getTextHeight:14.0f
                                      width:kScreenWidth-70
                                       text:detailModel.text
                                  linespace:5];
    
    return height+40;
}






@end











