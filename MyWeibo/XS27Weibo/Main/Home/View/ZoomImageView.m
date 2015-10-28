//
//  ZoomImageView.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/17.
//  Copyright © 2015年 www.huiwen.com 杭州汇文教育. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"

#import "UIImage+GIF.h"

@implementation ZoomImageView {
    NSURLConnection *_connection;
    float _totalLength;
    NSMutableData *_data;
    
    MBProgressHUD *_hud;
}

#pragma mark - 初始化方法
-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initTap];
        [self _createGif];
    }
    return self;
}

-(instancetype) initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self _initTap];
        [self _createGif];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _initTap];
        [self _createGif];
    }
    return self;
}


-(void) _initTap {
    //1.打开交互
    self.userInteractionEnabled = YES;
    
    //2.创建单击手势
    UITapGestureRecognizer *tapIn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    tapIn.numberOfTapsRequired = 1;
    tapIn.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapIn];
    
}

-(void) createViews {
    
    if (_scrollView == nil) {
        //1.创建滑动视图
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.window addSubview:_scrollView];
        
        //2.创建图片视图
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        //3.创建缩小手势
        UITapGestureRecognizer *tapOut = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        tapOut.numberOfTouchesRequired = 1;
        tapOut.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:tapOut];
        
        //4.添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 1;
        [_scrollView addGestureRecognizer:longPress];
    }
}

-(void) _createGif {
    _iconView = [[UIImageView alloc] init];
    _iconView.hidden = YES;
    _iconView.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_iconView];
}

#pragma mark - 长按手势
-(void) longPressAction:(UILongPressGestureRecognizer *) longPress {
    //如果是第一次长按，则添加
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否保存图片" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //保存图片
        UIImage *image = _fullImageView.image;
        
        //- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@", error);
}

#pragma mark - 点击手势
-(void) zoomIn {
    
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:self];
    }
    
    //1.隐藏原先的imageView
    self.hidden = YES;
    
    //2.实现_scrollView和_fullImageView
    [self createViews];
    
    //3.计算fullImageView的位置
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    
    //4.放大视图
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame = _scrollView.frame;
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
    }];
    
    //如果点击了图片
    if (self.fullImageString.length > 0) {
        
        if (_hud == nil) {
            _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
            _hud.mode = MBProgressHUDModeDeterminate;
        }
        _hud.progress = 0.0;
        [_hud show:YES];
        
        //5.发送请求，下载网络原图
        NSURL *url = [NSURL URLWithString:_fullImageString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        _connection = [NSURLConnection connectionWithRequest:request delegate:self];
    }
}

-(void) zoomOut {
    
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    //缩小动画
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        _fullImageView.frame = frame;
        
        //如果scroll内容偏移,偏移量也要考虑进去
        _fullImageView.top += _scrollView.contentOffset.y;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        _hud = nil;
        
        self.hidden = NO;
    }];
    
}

#pragma mark - NSURLConnection Delegate DataSource
//接收到数据
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
    CGFloat progress = _data.length / _totalLength;
    
    _hud.progress = progress;
    
}

//接收到响应
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *head = [httpResponse allHeaderFields];
//    NSLog(@"%@", head);
    NSString *lengStr = [head objectForKey:@"content-Length"];
    _totalLength = [lengStr floatValue];
    
    _data = [[NSMutableData alloc] init];
}

//连接完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_hud hide:YES];
    
    UIImage *image = [UIImage imageWithData:_data];
    _fullImageView.image = image;
    
    //尺寸处理
    // kScreenWidth/length = image.size.width/image.size.height
    
    CGFloat length = image.size.height/image.size.width * kScreenWidth;
    if (length > kScreenHeight) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _fullImageView.height = length;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, length);
            
        }];
    }
    
    //如果是动图，显示动画效果
    if (self.isGif) {
        _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
    }
}


#pragma mark - 长按手势相关函数





@end








