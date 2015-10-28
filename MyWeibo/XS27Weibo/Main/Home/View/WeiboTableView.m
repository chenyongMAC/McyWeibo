//
//  WeiboTableView.m
//  XS27Weibo
//
//  Created by gj on 15/10/12.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "WeiboTableView.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "UIImageView+WebCache.h"
#import "WeiboViewFrameLayout.h"

#import "UIView+UIViewController.h"
#import "WeiboDetailViewController.h"

@implementation WeiboTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.delegate = self;
        self.dataSource = self;
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
        
    }
    return self;

}

#pragma mark - UITableView DataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeiboCell" forIndexPath:indexPath];

    WeiboViewFrameLayout *frameLayout = _data[indexPath.row];
    cell.layout = frameLayout;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboViewFrameLayout *frameLayout = _data[indexPath.row];
    
    return frameLayout.frame.size.height + 80;
}


#pragma mark - UITableView DeleSoure
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboDetailViewController *vc = [[WeiboDetailViewController alloc] init];
    
    
    WeiboViewFrameLayout *layout = _data[indexPath.row];
    WeiboModel *model = layout.model;
    vc.weiboModel = model;
    //依据 响应者 链原理 找到视图控制器
    [self.viewController.navigationController pushViewController:vc animated:YES];
    
    
}

@end











