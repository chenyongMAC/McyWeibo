//
//  WeiboDetailView.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "WeiboDetailView.h"
#import "DetailModel.h"
#import "CommentCell.h"

static NSString *commentCellID = @"CommentCell";

@implementation WeiboDetailView

-(id) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _createHeaderView];
        
        self.delegate = self;
        self.dataSource = self;
    
        //注册CommentCell
        UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:commentCellID];
        
    }
    return self;
}

#pragma mark - 创建视图
-(void) _createHeaderView {
    //1.创建父视图
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    _headerView.backgroundColor = [UIColor clearColor];
    
    
    //2.加载xib， 创建UserView
    _userView = [[[NSBundle mainBundle] loadNibNamed:@"UserView" owner:self options:nil]lastObject];
    _userView.backgroundColor = [UIColor clearColor];
//    _userView.backgroundColor =  [UIColor colorWithWhite:0.5 alpha:0.1];
    _userView.width = kScreenWidth;
    [_headerView addSubview:_userView];
    
    
    //3.创建微博视图
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _weiboView.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [_headerView addSubview:_weiboView];
    
    
}

-(void) setWeiboModel:(WeiboModel *)weiboModel {
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        //1.微博视图布局对象
        WeiboViewFrameLayout *layoutFrame = [[WeiboViewFrameLayout alloc] init];
        
        layoutFrame.model = weiboModel;
        
        _weiboView.layout = layoutFrame;
        _weiboView.frame = layoutFrame.frame;
        _weiboView.top = _userView.bottom + 5;
        
        //2.用户视图
        _userView.weiboModel = weiboModel;
        
        //3.设置头视图
        _headerView.height = _weiboView.bottom;
        
        self.tableHeaderView = _headerView;
        
    }
}

#pragma mark - UITableView Delegate
//组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //1.创建组视图
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    
    //2.评论Label
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    // countLabel.backgroundColor = [UIColor clearColor];
    countLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    countLabel.textColor = [UIColor blackColor];
    
    
    //3.评论数量
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    int value = [total intValue];
    countLabel.text = [NSString stringWithFormat:@"评论:%d",value];
    [sectionHeaderView addSubview:countLabel];
    
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    
    return sectionHeaderView;
}

//设置组的头视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//设置单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailModel *model = self.commentDataArray[indexPath.row];
    //计算单元格的高度
    CGFloat height = [CommentCell getCommentHeight:model];
    
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID forIndexPath:indexPath];
    cell.detailModel = self.commentDataArray[indexPath.row];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}









@end










