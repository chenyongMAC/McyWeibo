//
//  WeiboDetailViewController.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "WeiboDetailViewController.h"
#import "AppDelegate.h"
#import "DetailModel.h"

@interface WeiboDetailViewController () {
    SinaWeiboRequest *_request;
}

@end

@implementation WeiboDetailViewController

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    //当界面弹出的时候，断开网络链接
    [_request disconnect];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTableView];
    [self _loadData];
}

#pragma mark - 创建tableView视图
-(void) createTableView {
    _tableView = [[WeiboDetailView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    
    
    _tableView.backgroundColor = [UIColor clearColor];
    //传递数据给子类化对象_tableView
    _tableView.weiboModel = self.weiboModel;
}

#pragma mark - 加载数据,发送微博request
-(void) _loadData {
//    NSString *weiboID = [self.weiboModel.weiboId stringValue];
    NSString *weiboID = self.weiboModel.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboID forKey:@"id"];
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    _request = [sinaweibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 100;
}

-(void) request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result {
    NSLog(@"网络请求成功");
    
    NSArray *array = [result objectForKey:@"comments"];
    NSMutableArray *detailModelArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dataDic in array) {
        DetailModel *detailModel = [[DetailModel alloc] initWithDataDic:dataDic];
        [detailModelArray addObject:detailModel];
    }
    
    _tableView.commentDataArray = detailModelArray;
    _tableView.commentDic = result;
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取微博对象
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaWeibo;
}



@end
