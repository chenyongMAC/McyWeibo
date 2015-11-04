//
//  DetailModel.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "DetailModel.h"

@implementation DetailModel

- (void)setAttributes:(NSDictionary *)dataDic {
    [super setAttributes:dataDic];
    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    self.user = user;
    
    NSDictionary *status = [dataDic objectForKey:@"status"];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:status];
    self.weibo = weibo;
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic != nil) {
        DetailModel *sourceComment = [[DetailModel alloc] initWithDataDic:commentDic];
        self.sourceComment = sourceComment;
    }
    
    //处理评论中的表情
    //self.text = [Utils parseTextImage:_text];
    
}

@end
