//
//  RightViewController.m
//  XS27Weibo
//
//  Created by gj on 15/10/10.
//  Copyright (c) 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "SendViewController.h"
#import "BaseNavController.h"
#import "LocationViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createViews];
    
}

-(void) _createViews {
    NSArray *imageNames = @[@"newbar_icon_1.png",
                            @"newbar_icon_2.png",
                            @"newbar_icon_3.png",
                            @"newbar_icon_4.png",
                            @"newbar_icon_5.png"];
    for (int i=0; i<imageNames.count; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(20, 64+i*(40+10), 40, 40)];
        button.normalImageName = imageNames[i];
        
        button.tag = i;
        [button addTarget:self action:@selector(buttonActions:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void) buttonActions:(UIButton *) button {
    if (button.tag == 0) {
        //先弹回右边导航控制器
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            //弹出发送微博控制器
            SendViewController *sendVC = [[SendViewController alloc] init];
            sendVC.title = @"发送微博";
            
            //创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:sendVC];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
            
        }];
    } else if (button.tag == 4) {
        //附近地点
        // 附近地点
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:^(BOOL finished) {
            
            
            LocationViewController *vc = [[LocationViewController alloc] init];
            vc.title = @"附近商圈";
            
            // 创建导航控制器
            BaseNavController *baseNav = [[BaseNavController alloc] initWithRootViewController:vc];
            [self.mm_drawerController presentViewController:baseNav animated:YES completion:nil];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
