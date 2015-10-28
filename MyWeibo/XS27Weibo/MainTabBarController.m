//
//  MainTabBarController.m
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavController.h"
#import "Common.h"

#import "AppDelegate.h"
#import "SinaWeibo.h"

#import "ThemeImageView.h"
#import "ThemeButton.h"
#import "ThemeLabel.h"

@interface MainTabBarController () {
    ThemeLabel *_badgeLabel;
    ThemeImageView *_badgeImageView;
}

@end

@implementation MainTabBarController{
    ThemeImageView *_selectedImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //警告：调用顺序不要变
    //01 加载子控制器
    [self _createSubControllers];
    //02 设置tabBar
    [self _creatTabBar];
 
    [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(timerActions:) userInfo:nil repeats:nil];
    
    
    //下拉刷新隐藏消息提示圆圈
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTabBar) name:kPullRefresh object:nil];
    
}

-(void) refreshTabBar {
    _badgeImageView.hidden = YES;
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
//@"Skins/cat/mask_navbar.png" tabBar背景
//@"Skins/cat/home_bottom_tab_arrow.png"  选中图片
//@"Skins/cat/home_tab_icon_1.png"  tabBar 图片

- (void)_creatTabBar{
    
    //01 移除tabBarButton
    for (UIView *view in self.tabBar.subviews) {
        //通过字符串获得类对象
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
 
    //02 背景图片
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    bgImageView.imageName = @"mask_navbar.png";
    //bgImageView.image = [UIImage imageNamed:@"Skins/cat/mask_navbar.png"];
    [self.tabBar addSubview:bgImageView];
    
    //03 选中图片
    
    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/5, 49)];
    //_selectedImageView.image = [UIImage imageNamed:@"Skins/cat/home_bottom_tab_arrow.png"];
    _selectedImageView.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImageView];
    
    
    //04 设置 按钮
//    NSArray *imageNames = @[@"Skins/cat/home_tab_icon_1.png",
//                            @"Skins/cat/home_tab_icon_2.png",
//                            @"Skins/cat/home_tab_icon_3.png",
//                            @"Skins/cat/home_tab_icon_4.png",
//                            @"Skins/cat/home_tab_icon_5.png"];
    NSArray *imageNames = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png"];
    CGFloat width = kScreenWidth/5;
    
    for (int i = 0; i<5; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i*width, 0, width, 49)];
        //[button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        
        
        button.normalImageName = imageNames[i];
        button.tag = i;
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
        [self.tabBar addSubview:button];
    
    }
    
}
- (void)selectAction:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
         _selectedImageView.center = button.center;
    }];
   
    self.selectedIndex = button.tag;
}

//加载子控制器
- (void)_createSubControllers{
    
//    UIStoryboard *storyBoard = [UIStoryboard  storyboardWithName:@"Home" bundle:nil];
//    BaseNavController *nav = [storyBoard instantiateInitialViewController];
    
    NSArray *names = @[@"Home",@"Message",@"Discover",@"Profile",@"More"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i  = 0; i<5; i++) {
        UIStoryboard *storyBoard = [UIStoryboard  storyboardWithName:names[i] bundle:nil];
        BaseNavController *nav = [storyBoard instantiateInitialViewController];
        [navArray addObject:nav];
    }
    self.viewControllers = navArray;
}

-(void) timerActions:(NSTimer *) timer {
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaweibo = appdelegate.sinaWeibo;
    
    [sinaweibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
 
    NSInteger badgeWidth = kScreenWidth/5;
    
    if (_badgeImageView == nil) {
        _badgeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(badgeWidth-32, 0, 32, 32)];
        _badgeImageView.imageName = @"number_notify_9.png";
        [self.tabBar addSubview:_badgeImageView];
        
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImageView.bounds];
        _badgeLabel.colorName = @"Timeline_Notice_Color";
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        [_badgeImageView addSubview:_badgeLabel];
    }
    
    if (count == 0) {
        _badgeImageView.hidden = YES;
    } else if (count > 99) {
        _badgeLabel.text = @"..";
        _badgeImageView.hidden = NO;
    } else {
        _badgeLabel.text = [NSString stringWithFormat:@"%li", count];
        _badgeImageView.hidden = NO;
    }
    
}



@end
