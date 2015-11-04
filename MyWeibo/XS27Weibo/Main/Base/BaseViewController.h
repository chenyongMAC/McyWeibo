//
//  BaseViewController.h
//  XS27Weibo
//
//  Created by gj on 15/10/8.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"


@interface BaseViewController : UIViewController {
    UIWindow *_tipWindow;
}
- (void)setNavItem;

#pragma mark - 加载进度条方法
-(void) showHUD:(NSString *) title;
-(void) hideHUD;
-(void) completeHUD:(NSString *) title;

- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;

@end
