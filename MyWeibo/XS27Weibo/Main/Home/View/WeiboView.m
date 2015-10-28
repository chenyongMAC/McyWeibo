//
//  WeiboView.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/12.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "WeiboView.h"
#import "UIImageView+WebCache.h"
#import "WXLabel.h"
#import "ThemeManager.h"

@implementation WeiboView

-(instancetype) init {
    self = [super init];
    if (self) {
        [self _createSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _createSubView];
    }
    return self;
}

- (void)awakeFromNib
{
    
}


#pragma mark - 初始化空间，只是分配空间
-(void) _createSubView {
    _textLabel = [[WXLabel alloc] init];
    _textLabel.font = [UIFont systemFontOfSize:15];
    _textLabel.linespace = 5.0;
    self.textLabel.wxLabelDelegate = self;
    
    _sourceLabel = [[WXLabel alloc] init];
    _sourceLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.linespace = 5.0;
    self.sourceLabel.wxLabelDelegate = self;
    
    _imgView = [[ZoomImageView alloc] init];
    
    _bgImgView = [[ThemeImageView alloc] init];
    _bgImgView.leftCap = 30;
    _bgImgView.topCap = 30;
    
    [self addSubview:_bgImgView];
    [self addSubview:_textLabel];
    [self addSubview:_sourceLabel];
    [self addSubview:_imgView];
    
    //添加主题切换监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDicChange:) name:kThemeNameDidChangedNotification object:nil];
    
}

#pragma mark 主题切换通知
- (void)themeDicChange:(NSNotification *)notification{
    //Timeline_Content_color
    
    _textLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    _sourceLabel.textColor = [[ThemeManager shareInstance] getThemeColor:@"Timeline_Content_color"];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setLayout:(WeiboViewFrameLayout *)layout {
    if (_layout != layout) {
        _layout = layout;
        [self setNeedsLayout];
    }
}

-(void) layoutSubviews {
    [super layoutSubviews];
    WeiboModel *model = _layout.model;
    
    _textLabel.frame = _layout.textFrame;
    _textLabel.text = model.text;
    
    if (model.reWeiboModel != nil) {
        //有转发
        //显示背景和被转发的微博的label
        _bgImgView.hidden = NO;
        _bgImgView.frame = _layout.bgImgFrame;
        _bgImgView.imageName = @"timeline_rt_border_9.png";
        
        _sourceLabel.hidden = NO;
        _sourceLabel.frame = _layout.srTextFrame;
        _sourceLabel.text = model.reWeiboModel.text;
        
        //图片（被转发的微博）
        NSString *imageStr = model.reWeiboModel.thumbnailImage;
        if (imageStr == nil) {
            _imgView.hidden = YES;
        } else {
            _imgView.hidden = NO;
            _imgView.frame = _layout.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
            
            //传递网络原图地址
            _imgView.fullImageString = model.reWeiboModel.originalImage;
        }
        
    } else {
        //无转发
        _bgImgView.hidden = YES;
        _sourceLabel.hidden = YES;
        
        //图片
        NSString *imageStr = model.thumbnailImage;
        if (imageStr == nil) {
            _imgView.hidden = YES;
        } else {
            _imgView.hidden = NO;
            _imgView.frame = _layout.imgFrame;
            [_imgView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
            
            //传递网络原图地址
            _imgView.fullImageString = model.originalImage;
        }
    }
    
    //如果微博内容中有图片
    if (_imgView.hidden == NO) {
        //设置gif下标图片
        _imgView.iconView.frame = CGRectMake(_imgView.width-24, _imgView.height-15, 24, 14);
        
        //判断是否是gif图
        NSString *extension = [NSString string];
        if (model.reWeiboModel != nil) {
            extension = [model.reWeiboModel.thumbnailImage pathExtension];
        } else {
            extension = [model.thumbnailImage pathExtension];
        }
        if ([extension isEqualToString:@"gif"]) {
            _imgView.isGif = YES;
            _imgView.iconView.hidden = NO;
        } else {
            _imgView.isGif = NO;
            _imgView.iconView.hidden = YES;
        }
    }
    
}

#pragma mark - WXLabel Delegate
-(NSString *) contentsOfRegexStringWithWXLabel:(WXLabel *)wxLabel {
    //需要添加链接字符串的正则表达式：@用户、http://、#话题#
    NSString *regex1 = @"@\\w+";
    NSString *regex2 = @"http(s)?://([A-Za-z0-9._-]+(/)?)*";
    NSString *regex3 = @"#\\w+#";
    NSString *regex = [NSString stringWithFormat:@"(%@)|(%@)|(%@)",regex1,regex2,regex3];
    return regex;
}

-(void) toucheBenginWXLabel:(WXLabel *)wxLabel withContext:(NSString *)context {
    NSLog(@"点击");
}

-(UIColor *) linkColorWithWXLabel:(WXLabel *)wxLabel {
    return  [[ThemeManager shareInstance] getThemeColor:@"Link_color"];
}

- (UIColor *)passColorWithWXLabel:(WXLabel *)wxLabel{
    
    return  [UIColor redColor];
}


@end






