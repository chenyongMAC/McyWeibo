//
//  WeiboViewFrameLayout.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/12.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "WeiboViewFrameLayout.h"
#import "WXLabel.h"

@implementation WeiboViewFrameLayout

-(void) setModel:(WeiboModel *)model {
    if (_model != model) {
        _model = model;
        
        [self _calculateLayoutFrames];
    }
}

//-(void) _calculateLayoutFrames {
//    
//    //计算frame高度
//    _textFrame = CGRectMake(5, 5, 280, 60);
//    _srTestFrame = CGRectMake(5, 70, 280, 70);
//    _imgFrame = CGRectMake(5, 145, 80, 80);
//    _bgImgFrame = CGRectMake(5, 65, 280, 160);
//    _frame = CGRectMake(60, 50, 280, 230);
//    
//}

-(void) _calculateLayoutFrames {
    //1.微博视图的frame
    self.frame = CGRectMake(55, 40, kScreenWidth-55-10, 0);
    
    //2.微博内容的frame
    //1>计算微博内容的宽度
    CGFloat textWidth = CGRectGetWidth(self.frame) - 20;
    
    //2>计算微博内容的高度
    NSString *text = self.model.text;
    CGFloat textHeight = [WXLabel getTextHeight:15
                                          width:textWidth
                                           text:text linespace:5.0];
    self.textFrame = CGRectMake(10, 0, textWidth, textHeight);
    
    //3.转发微博内容的frame：高度、宽度、Y坐标
    if (self.model.reWeiboModel != nil) {
#pragma mark - 有转发微博
        NSString *reText = self.model.reWeiboModel.text;
        
        CGFloat reTextWidth = textWidth - 20;
        CGFloat reTextHeight = [WXLabel getTextHeight:14 width:reTextWidth text:reText linespace:5.0];
        
        CGFloat Y = CGRectGetMaxY(self.textFrame) + 10;
        self.srTextFrame = CGRectMake(20, Y, reTextWidth, reTextHeight);
        
        //4.转发微博图片
        NSString *thumbnailImage = self.model.reWeiboModel.thumbnailImage;
        if (thumbnailImage != nil) {
            CGFloat Y = CGRectGetMaxY(self.srTextFrame) + 10;
            CGFloat X = CGRectGetMinX(self.srTextFrame);
            self.imgFrame = CGRectMake(X, Y, 80, 80);
        }
        
        //5.转发微博的背景
        CGFloat bgX = CGRectGetMinX(self.textFrame);
        CGFloat bgY = CGRectGetMaxY(self.textFrame);
        CGFloat bgWidth = CGRectGetWidth(self.textFrame);
        CGFloat bgHeight = CGRectGetMaxY(self.srTextFrame);
        if (thumbnailImage != nil) {
            bgHeight = CGRectGetMaxY(self.imgFrame);
        }
        bgHeight -= CGRectGetMaxY(self.textFrame);
        bgHeight += 10;
        
        self.bgImgFrame = CGRectMake(bgX, bgY, bgWidth, bgHeight);
        
    } else {
#pragma mark - 无转发微博
        //微博图片
        NSString *thumbnailImage = self.model.thumbnailImage;
        if (thumbnailImage != nil) {
            
            CGFloat imgX = CGRectGetMinX(self.textFrame);
            CGFloat imgY = CGRectGetMaxY(self.textFrame)+10;
            self.imgFrame = CGRectMake(imgX, imgY, 80, 80);
        }
    }
    
    //6.计算微博视图的高度：微博视图最底部子视图的Y坐标
    CGRect f = self.frame;
    if (self.model.reWeiboModel != nil) {
        f.size.height = CGRectGetMaxY(_bgImgFrame);
    }
    else if(self.model.thumbnailImage != nil) {
        f.size.height = CGRectGetMaxY(_imgFrame);
    }
    else {
        f.size.height = CGRectGetMaxY(_textFrame);
    }
    self.frame = f;

}


@end
