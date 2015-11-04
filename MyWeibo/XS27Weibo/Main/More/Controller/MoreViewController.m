//
//  MoreViewController.m
//  HWWeibo
//
//  Created by gj on 15/9/9.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"

static NSString *moreCellId = @"moreCellId";

@interface MoreViewController (){
    
    UITableView *_tableView;
    
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
}

#pragma mark - 刷新界面
- (void)viewWillAppear:(BOOL)animated{
    [_tableView reloadData];
}

#pragma mark - 创建tableView
- (void)_createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellId];
    
}


#pragma mark - tableViewSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SinaWeibo *sinaweibo = [self sinaWeibo];
            if (sinaweibo.isAuthValid) {
                cell.themeUserIDLabel.text = sinaweibo.userID;
            } else {
                cell.themeUserIDLabel.text = @"请登入";
            }
            cell.themeUserIDLabel.center = cell.contentView.center;
        } else if (indexPath.row == 1) {
            cell.themeImageView.imageName = @"more_icon_theme.png";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManager shareInstance].themeName;
        } else if (indexPath.row == 2) {
            cell.themeImageView.imageName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }
    else if (indexPath.section == 1) {
        cell.themeTextLabel.text = @"意见反馈";
        cell.themeImageView.imageName = @"more_icon_feedback.png";
    }
    else {
        cell.themeTextLabel.text = @"登出当前账号";
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.themeTextLabel.center = cell.contentView.center;
    }
    
    //设置cell右边的样式
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    } else if (section == 1) {
        return 1;
    } else {
        return 1;
    }
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.清除选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //2.针对不同栏 不同效果
    if (indexPath.section==0 && indexPath.row == 1) {
        //切换主题
        ThemeTableViewController *themeTableVC = [[ThemeTableViewController alloc] init];
        themeTableVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self.navigationController pushViewController:themeTableVC animated:YES];
    }
    
    if (indexPath.section==0 && indexPath.row==0) {
        SinaWeibo *sinaweibo = [self sinaWeibo];
        //1.已经登入账号
        if (sinaweibo.isAuthValid) {
//            [sinaweibo requestWithURL:@"users/show.json"
//                               params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
//                           httpMethod:@"GET"
//                             delegate:self];
        } else {
        //2.登入账号
        [sinaweibo logIn];
        }
        
        //刷新
//        [_tableView reloadData];    //位置不对
    }
    
    if (indexPath.section==2 && indexPath.row==0) {
        //登出栏
        SinaWeibo *sinaweibo = [self sinaWeibo];
        if ([sinaweibo isLoggedIn]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"退出当前账号？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请先登入!" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
            [alertView show];
        }
    }

    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //确认退出
        SinaWeibo *sinaweibo = [self sinaWeibo];
        [sinaweibo logOut];
    }
}

-(SinaWeibo *) sinaWeibo {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaWeibo;
}

@end
