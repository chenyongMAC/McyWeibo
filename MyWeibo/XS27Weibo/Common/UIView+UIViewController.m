//
//  UIView+UIViewController.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

-(UIViewController *) viewController {
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
        
    }
    
    return nil;
}

@end
