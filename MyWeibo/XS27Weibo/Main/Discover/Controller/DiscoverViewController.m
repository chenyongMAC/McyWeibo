//
//  DiscoverViewController.m
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "DiscoverViewController.h"
#import "NearByViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nearByWeibo:(UIButton *)sender {
    NearByViewController *nearVC = [[NearByViewController alloc] init];
    [self.navigationController pushViewController:nearVC animated:YES];
    
}


- (IBAction)nearByPeople:(UIButton *)sender {
}


@end











