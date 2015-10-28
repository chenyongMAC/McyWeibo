//
//  HomeViewController.m
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
#import "WeiboModel.h"
#import "WeiboViewFrameLayout.h"
#import "MJRefresh.h"
#import <AudioToolbox/AudioToolbox.h>

#import "MainTabBarController.h"
#import "Common.h"


@interface HomeViewController () {
    WeiboTableView *_tableView;
    
    ThemeImageView *_barImageView;
    ThemeLabel *_barLabel;
}

@end

@implementation HomeViewController

//#pragma mark - 刷新数据
//-(void) viewWillAppear:(BOOL)animated {
//    [self _loadData];
//    [_tableView reloadData];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
    [self setNavItem];
    
    [self _loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTableView{
    
    _tableView = [[WeiboTableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    
    
    [self.view addSubview:_tableView];
}

- (void)_loadData{
    
    //显示加载进度条
    [self showHUD:@"加载数据"];
    
    
    //测试 获取微博
    
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"10" forKey:@"count"];
    
    if ([sinaWeibo isLoggedIn]) {
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                           params:params
                       httpMethod:@"GET"
                         delegate:self];
        
        request.tag = 100;
    }
    
}

#pragma mark - 加载最新数据
-(void) _loadNewData {
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"10" forKey:@"count"];
    
    //设置since_id
    if (_data.count > 0) {
        //取得第一条数据
        WeiboViewFrameLayout *layout = [_data firstObject];
        WeiboModel *model = layout.model;
        [params setObject:model.weiboIdStr forKey:@"since_id"];
    }
    
    if ([sinaWeibo isLoggedIn]) {
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                           params:params
                       httpMethod:@"GET"
                         delegate:self];
        request.tag = 101;
    }
}

#pragma mark - 加载更多数据
-(void) _loadMoreData {
    
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"10" forKey:@"count"];
    
    //设置maxID
    if (_data.count > 0) {
        //取得最后一条数据
        WeiboViewFrameLayout *layout = [_data lastObject];
        WeiboModel *model = layout.model;
        [params setObject:model.weiboIdStr forKey:@"max_id"];
    }
    
    if ([sinaWeibo isLoggedIn]) {
        SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
                           params:params
                       httpMethod:@"GET"
                         delegate:self];
        request.tag = 99;
    }
}


#pragma mark - 创建下拉刷新提示框
-(void) showNewWeiboCount:(NSInteger) count {
    if (_barImageView == nil) {
        _barImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, -40, kScreenWidth - 10, 40)];
        _barImageView.imageName = @"timeline_notify.png";
        [self.view addSubview:_barImageView];
        
        _barLabel = [[ThemeLabel alloc] initWithFrame:_barImageView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        [_barImageView addSubview:_barLabel];
    }

    if (count>0) {
        _barLabel.text = [NSString stringWithFormat:@"更新了%ld条微博", (long)count];
        //动画效果
        [UIView animateWithDuration:0.5 animations:^{
            _barImageView.transform = CGAffineTransformMakeTranslation(0, 40+64+5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [UIView setAnimationDelay:0.9];
                _barImageView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailWithError");
}


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
//    NSLog(@"%@", result);
    
    //解析数据
    NSArray *statuesArray = [result objectForKey:@"statuses"];
    NSMutableArray *layoutFrameArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in statuesArray) {
        
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dic];
        WeiboViewFrameLayout *frameLayout = [[WeiboViewFrameLayout alloc] init];
        
        //model的数据不是直接传递给Cell，而是先传递给framelayout进行数据处理
        frameLayout.model = model;
        
        [layoutFrameArray addObject:frameLayout];
        
    }
    
    if (_data == nil) {
        _data = layoutFrameArray;
//        [self hideHUD];
        [self completeHUD:@"加载完成"];
    }
    if (request.tag == 100) {
        //加载数据
        _data = layoutFrameArray;
        
    } else if (request.tag == 99) {
        //加载更多数据
        [_data removeLastObject];
        [_data addObjectsFromArray:layoutFrameArray];
        
    } else if (request.tag == 101) {
        //加载最新数据
        [[NSNotificationCenter defaultCenter] postNotificationName:kPullRefresh object:nil];
        
        
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, layoutFrameArray.count)];
        [_data insertObjects:layoutFrameArray atIndexes:indexSet];
    }
    if (_data.count != 0) {
        _tableView.data = _data;
        [_tableView reloadData];
    }
    
    [_tableView.header endRefreshing];
    [_tableView.footer endRefreshing];
    
    //显示刷新消息数提示框
    [self showNewWeiboCount:layoutFrameArray.count];
    [self playSystemSound];
    
}


#pragma mark - 系统声音
-(void) playSystemSound {
    //系统声音
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
    NSURL *url = [NSURL fileURLWithPath:soundPath];
    
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    AudioServicesPlaySystemSound(soundID);
}


@end
