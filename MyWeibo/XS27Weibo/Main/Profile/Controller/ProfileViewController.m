//
//  ProfileViewController.m
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "ProfileViewController.h"
#import "PersonalCell.h"
#import "WeiboViewFrameLayout.h"
#import "AppDelegate.h"
#import "WeiboModel.h"
#import "ClickCell.h"
#import "WeiboCell.h"

static NSString *identifier = @"PersonalCell";
static NSString *clickCellID = @"ClickCell";
static NSString *weiboCellID = @"WeiboCell";

@interface ProfileViewController () {
    UITableView *_tableView;
    NSMutableArray *_layoutArray;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _loadData];
    [self _createViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) _createViews {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;

//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:_tableView];
}

-(void) _loadData {
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    if ([sinaWeibo isLoggedIn]) {
        [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                           params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                       httpMethod:@"GET"
                         delegate:self];
    }
    
}


#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailWithError");
}


- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
//    NSLog(@"%@", result);
    
#pragma mark - 加载数据
    NSDictionary *statuesArray = [result objectForKey:@"statuses"];
    NSLog(@"%@", statuesArray);
    
    _layoutArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in statuesArray) {
        
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dic];
        WeiboViewFrameLayout *layout = [[WeiboViewFrameLayout alloc] init];
        layout.model = model;
        
        [_layoutArray addObject:layout];
    }
    [_tableView reloadData];
}


#pragma mark - UITableViewDataSource 
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _modelArray.count;
    if (section > 1) {
        return 5;
    } else {
        return 1;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else if (indexPath.section == 1){
        return 50;
    } else {
        WeiboViewFrameLayout *frameLayout = _layoutArray[indexPath.row];
        
        return frameLayout.frame.size.height + 80;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UINib *nib = [UINib nibWithNibName:@"PersonalCell" bundle:[NSBundle mainBundle]];
        [_tableView registerNib:nib forCellReuseIdentifier:identifier];
        
        PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        
        cell.layout = _layoutArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    } else  if (indexPath.section == 1) {
        UINib *nib = [UINib nibWithNibName:@"ClickCell" bundle:[NSBundle mainBundle]];
        [_tableView registerNib:nib forCellReuseIdentifier:clickCellID];
        
        ClickCell *cell = [tableView dequeueReusableCellWithIdentifier:clickCellID forIndexPath:indexPath];
        
        cell.layout = _layoutArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    } else {
        UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:[NSBundle mainBundle]];
        [_tableView registerNib:nib forCellReuseIdentifier:weiboCellID];
        
        WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:weiboCellID forIndexPath:indexPath];
        
        cell.layout = _layoutArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    
    
}



@end






