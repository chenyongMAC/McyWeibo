//
//  WeiboAnnotationView.m
//  HWWeibo
//
//  Created by gj on 15/9/2.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, 100, 40);

        [self _createViews];
    
    }
    return  self;

}
//创建子视图
- (void)_createViews{
    
    _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_userHeadImageView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _textLabel.backgroundColor = [UIColor lightGrayColor];
    _textLabel.textColor = [UIColor blackColor];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.numberOfLines = 3;
    [self addSubview:_textLabel];
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    
    _userHeadImageView.frame = CGRectMake(0, 0, 40, 40);
    _textLabel.frame = CGRectMake(40, 0, 100, 40);
    
    
    //通过annotation得到 微博model，显示数据
    WeiboAnnotation *annotation = self.annotation;
    
    _textLabel.text = annotation.model.text;
    NSString *urlStr = annotation.model.userModel.profile_image_url;
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];

    
}




@end
