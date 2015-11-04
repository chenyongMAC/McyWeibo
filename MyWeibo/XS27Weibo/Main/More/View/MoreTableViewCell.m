//
//  MoreTableViewCell.m
//  HWWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "MoreTableViewCell.h"
#import "UIViewExt.h"


@implementation MoreTableViewCell

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _createSubView];
        [self themeChangedAction];
        
        //注册通知接收器
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChangedAction) name:kThemeNameDidChangedNotification object:nil];
        
    }
    return self;
}

-(void) themeChangedAction {
    self.backgroundColor = [[ThemeManager shareInstance] getThemeColor:@"More_Item_color"];
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) _createSubView {
    //切换主题图片
    _themeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(7, 7, 30, 30)];
    
    
    //切换主题Label
    _themeTextLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(_themeImageView.right+5, 11, 200, 20)];
    _themeTextLabel.font = [UIFont boldSystemFontOfSize:16];
    _themeTextLabel.colorName = @"More_Item_Text_color";
    
    
    
    //切换主题DetailLabel
    _themeDetailLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(self.right-95-30, 11, 95, 20)];
    _themeDetailLabel.font = [UIFont boldSystemFontOfSize:15];
    _themeDetailLabel.colorName = @"More_Item_Text_color";
    _themeDetailLabel.textAlignment = NSTextAlignmentRight;
    
    
    //用户IDLabel
    _themeUserIDLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(50, 5, 200, 30)];
    _themeUserIDLabel.font = [UIFont boldSystemFontOfSize:16];
    _themeUserIDLabel.colorName = @"More_Item_Text_color";
    
    
    [self.contentView addSubview:_themeImageView];
    [self.contentView addSubview:_themeTextLabel];
    [self.contentView addSubview:_themeDetailLabel];
    [self.contentView addSubview:_themeUserIDLabel];
}

@end
