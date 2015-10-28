//
//  WeiboModel.m
//  XSWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "WeiboModel.h"
#import "RegexKitLite.h"

@implementation WeiboModel


- (NSDictionary*)attributeMapDictionary{
    
    //   @"属性名": @"数据字典的key"
    NSDictionary *mapAtt = @{
                             @"createDate":@"created_at",
                             @"weiboId":@"id",
                             @"text":@"text",
                             @"source":@"source",
                             @"favorited":@"favorited",
                             @"thumbnailImage":@"thumbnail_pic",
                             @"bmiddlelImage":@"bmiddle_pic",
                             @"originalImage":@"original_pic",
                             @"geo":@"geo",
                             @"repostsCount":@"reposts_count",
                             @"commentsCount":@"comments_count",
                             @"weiboIdStr":@"idstr"
                    
                             };
    
    return mapAtt;
}


- (void)setAttributes:(NSDictionary *)dataDic{
    //调用父类的设置方法
   [super setAttributes:dataDic];

    //解析来源
    if (_source != nil) {
        NSString *regex = @">.+<";
        NSArray *array = [_source componentsMatchedByRegex:regex];
        if (array.count != 0) {
            NSString *str = array[0];
            str = [str substringWithRange:NSMakeRange(1, str.length - 2)];
            _source = [NSString stringWithFormat:@"来源：%@", str];
        }
    }
    
    //解析用户信息
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        _userModel = [[UserModel alloc] initWithDataDic:userDic];
    }
    
    //解析被转发的微博
    NSDictionary *reWeiBoDic = [dataDic objectForKey:@"retweeted_status"];
    if (reWeiBoDic != nil) {
        _reWeiboModel = [[WeiboModel alloc] initWithDataDic:reWeiBoDic];
        //添加被转发者的姓名
        NSString *name = _reWeiboModel.userModel.name;
        _reWeiboModel.text = [NSString stringWithFormat:@"@%@:%@", name, _reWeiboModel.text];
    }
    
    //解析表情
    NSString *regex = @"\\[\\w+\\]";
    NSArray *faceItems = [_text componentsMatchedByRegex:regex];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *faceConfigArray = [NSArray arrayWithContentsOfFile:filePath];
    for (NSString *faceName in faceItems) {
        //谓词过滤：将符合“self.chs = \\[\\w+\\]”的内容都留下来
        NSString *t = [NSString stringWithFormat:@"self.chs='%@'",faceName];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:t];
        
        NSArray *items = [faceConfigArray filteredArrayUsingPredicate:predicate];
        
        if (items.count > 0) {
            //经过谓词过滤后，items中的每一项(items[i])，都只有符合条件的内容，所以下面可以直接使用items[0]来获取键值
            NSString *imageName = [items[0] objectForKey:@"png"];
            
            NSString *urlStr = [NSString stringWithFormat:@"<image url = '%@'>", imageName];
            _text = [_text stringByReplacingOccurrencesOfString:faceName withString:urlStr];
        }
    }
    
}



@end
