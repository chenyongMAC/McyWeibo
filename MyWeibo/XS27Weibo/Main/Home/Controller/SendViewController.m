//
//  SendViewController.m
//  XS27Weibo
//
//  Created by 陈勇 on 15/10/19.
//  Copyright (c) 2015年 mac All rights reserved.
//

#import "SendViewController.h"
#import "ThemeButton.h"
#import "MMDrawerController.h"
#import "DataService.h"
#import "SendViewController.h"


@interface SendViewController () {
    UIImage *_sendImage;
}
@end

@implementation SendViewController

#pragma mark - 初始化方法
-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
    return self;
}

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    
    [_textView becomeFirstResponder];
}


//-(void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear: animated ];
//    
//    //弹出键盘
//    [_textView becomeFirstResponder];
//}

#pragma mark - 键盘监听
-(void) keyBoardWillShow:(NSNotification *) notification {
    //1.获取键盘的frame
    NSValue *bounsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //2.获取键盘高度
    CGRect frame = [bounsValue CGRectValue];
//    CGFloat height = frame.size.height;
    
    //3.调整视图的高度
//    _textView.height = kScreenHeight - _editorBar.height - height - 64;
//    _editorBar.top = _textView.bottom;
//    _editorBar.bottom = kScreenHeight - height - 64;
    _editorBar.bottom = frame.origin.y - 64;
    
}

#pragma mark - 创建子视图
-(void) _createNavItems {
    //1.关闭按钮
    ThemeButton *closeBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeBtn.normalImageName = @"button_icon_close.png";
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    
    
    //2.发送按钮
    ThemeButton *sendBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendBtn.normalImageName = @"button_icon_ok.png";
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    [self.navigationItem setRightBarButtonItem:sendItem];

}

-(void) closeAction {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        [mmDrawer closeDrawerAnimated:YES completion:NULL];
    }
    
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) sendAction {
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容为空";
    } else if (text.length > 140) {
        error = @"微博内容大于140字符";
    }
    if (error != nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:text forKeyedSubscript:@"status"];
    
    //发送
//    [DataService sendWeibo:params block:^(id result) {
//        NSLog(@"发送反馈：%@", result);
//        [self closeAction];
//    }];
    
    //发送
    AFHTTPRequestOperation *operation = [DataService sendWeibo:text image:_sendImage block:^(id result) {
        NSLog(@"发送成功");
        
        [self showStatusTip:@"发送完成" show:NO operation:nil];
    }];
    
    [self showStatusTip:@"正在发送" show:YES operation:operation];
    
    [self closeAction];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建子视图
    [self _createNavItems];
    
    //创建工具栏
    [self _createEditorViews];
    
    
}

-(void) _createEditorViews {
    //1.文本输入视图
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _textView.font = [UIFont systemFontOfSize:16.0f];
//    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = YES;
    
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
//    _textView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    [self.view addSubview:_textView];
    
    //2.编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 55)];
    _editorBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_editorBar];
    
    //3.创建多个编辑按钮
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];
    for (int i=0; i<imgs.count; i++) {
        NSString *imgName = imgs[i];
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(15+(kScreenWidth/5)*i, 20, 40, 33)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+i;
        button.normalImageName = imgName;
        [_editorBar addSubview:button];
    }
    
    //显示位置信息
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    _locationLabel.backgroundColor = [UIColor lightGrayColor];
    _locationLabel.textColor = [UIColor blackColor];
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.hidden = YES;
    [_editorBar addSubview:_locationLabel];
}

-(void) buttonAction:(UIButton *) button {
    NSLog(@"%li", button.tag);
    
    if (button.tag == 10) {
        [self _selectPhoto];
    } else if (button.tag == 13) {
        [self _location];
    } else if (button.tag == 14) {
        BOOL isFirstResponder = _textView.isFirstResponder;
        
        //输入框是否是第一响应者，如果是，说明键盘已经显示
        if (isFirstResponder) {
            //隐藏键盘
            [_textView resignFirstResponder];
            //显示表情
            [self _showFaceView];
            //隐藏键盘
            
        } else {
            //隐藏表情
            [self _hideFaceView];
            
            //显示键盘
            [_textView becomeFirstResponder];
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 选择图片
-(void) _selectPhoto {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheet Delegate 
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerControllerSourceType soureType;
    
    if (buttonIndex == 0) {
        //拍照
        soureType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
        }
    } else if (buttonIndex == 1) {
        //选择相册
        soureType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    } else {
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = soureType;
    picker.delegate = self;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - 照片选择代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //1.退出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //2.取出相片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //3.显示小图
    if (_zoomImageView == nil) {
        _zoomImageView = [[ZoomImageView alloc] initWithImage:image];
        _zoomImageView.frame = CGRectMake(10, _textView.bottom+10, 80, 80);
        [self.view addSubview:_zoomImageView];
        
        _zoomImageView.delegate = self;
    }
    
    _zoomImageView.image = image;
    _sendImage = image;
}

#pragma mark - ZoomImageView Delegate
-(void) imageWillZoomIn:(ZoomImageView *)imageView {
    [_textView resignFirstResponder];
}

-(void) imageWillZoomOut:(ZoomImageView *)imageView {
    [_textView becomeFirstResponder];
}


#pragma mark - 地理位置
- (void)_location{
    
    /*
     修改 info.plist 增加以下两项
     NSLocationWhenInUseUsageDescription  BOOL YES
     NSLocationAlwaysUsageDescription         string “提示描述”
     */
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        if (kVersion > 8.0) {
            //获取授权使用地理位置服务
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];//设置定位精确度
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
}


//代理 获取定位数据
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
    //停止定位
    [_locationManager stopUpdatingLocation];
    //取得位置信息
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度%lf,纬度%lf",coordinate.longitude,coordinate.latitude);
    
    
    //地理位置反编码，通过坐标信息获取 位置详情
    
    //一 新浪位置反编码 接口说明  http://open.weibo.com/wiki/2/location/geo/geo_to_address
    
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    
    __weak SendViewController* weakSelf = self;
    
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSLog(@"%@",result);
        
        __strong SendViewController *strongSelf = weakSelf;
        
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count > 0) {
            NSDictionary *geo = [geos lastObject];
            
            NSString *addr = [geo objectForKey:@"address"];
            NSLog(@"%@",addr);
            
            strongSelf->_locationLabel.hidden = NO;
            strongSelf->_locationLabel.text = addr;
            
        }
        
    }];
    
    //二 iOS自己内置
    
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        CLPlacemark *place = [placemarks lastObject];
//        NSLog(@"%@",place.name);
//        
//    }];


}

#pragma mark - 表情处理

- (void)_showFaceView{
    
    //创建表情面板
    if (_faceViewPanel == nil) {
        
        
        _faceViewPanel = [[FaceScrollView alloc] init];
        [_faceViewPanel setFaceViewDelegate:self];
        //放到底部
        _faceViewPanel.top  = kScreenHeight-64;
        [self.view addSubview:_faceViewPanel];
    }
    
    //显示表情
    [UIView animateWithDuration:0.3 animations:^{
        
        _faceViewPanel.bottom = kScreenHeight-64;
        //重新布局工具栏、输入框
        _editorBar.bottom = _faceViewPanel.top;
        
    }];
}

//隐藏表情
- (void)_hideFaceView {
    
    //隐藏表情
    [UIView animateWithDuration:0.3 animations:^{
        _faceViewPanel.top = kScreenHeight-64;
        
    }];
    
}


- (void)faceDidSelect:(NSString *)text{
    NSLog(@"选中了%@",text);
    
    _textView.text = [NSString stringWithFormat:@"%@%@", _textView.text,text];
}


@end











