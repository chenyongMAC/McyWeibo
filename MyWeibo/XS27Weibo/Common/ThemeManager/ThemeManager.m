

#import "ThemeManager.h"

@implementation ThemeManager{
    
    NSDictionary *_themeConfig; //Skins/cat
    NSDictionary *_colorConfig; // 颜色配置字典
}

//实现单例 整个程序运行期间  只创建一个 管家对象
+ (ThemeManager *)shareInstance{
    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    return  instance;
}



- (instancetype)init{
    self = [super init];
    if (self) {
        //01 设置默认主题名字，优先从本地文件中读取
        _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (_themeName.length == 0) {
            _themeName = @"Cat";
        }
        
        //02 _themeConfig 字典存储 主题名 与主题包 路径的对应关系
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
        //03 读取config.plist文件，把颜色值配置字典读出来
        
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return  self;
}

//当主题名修改的时候触发通知
- (void)setThemeName:(NSString *)themeName{
    
    if (![_themeName isEqualToString:themeName]) {
        _themeName = [themeName copy];
        
        //01 把记录保存到持久化文件中
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //02 读取config.plist文件，把颜色值配置字典读出来
        
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //03 当主题名字改变的时候  发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeNameDidChangedNotification object:nil];
    }
}

- (UIColor *)getThemeColor:(NSString *)colorName{
    // 01 读取config.plist文件，把颜色值字典 读取出来
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r =  [rgbDic[@"R"] floatValue];
    CGFloat g =  [rgbDic[@"G"] floatValue];
    CGFloat b =  [rgbDic[@"B"] floatValue];

    CGFloat alpha = 1;

    if (rgbDic[@"alpha"] != nil) {
        alpha = [rgbDic[@"alpha"] floatValue];
    }
    
    // 02 根据colorName读取字典 找到RGB值
    
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return  color;
}

- (UIImage *)getThemeImage:(NSString *)imageName{
    // 获取 主题包路径
    NSString *themePath = [self themePath];
    // 拼接 主题路径 + imageName
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    // 得到 UIImage
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return  image;
}

//获取主题包路径
- (NSString *)themePath{
   //bundle资源根路径
   NSString *resPath =  [[NSBundle mainBundle]  resourcePath]; //+ /Skins/cat
   //在_themeConfig字典中  获得主题名字 对应的主题包路径后缀
   NSString *pathSufix =  [_themeConfig objectForKey:self.themeName];// Skins/cat
   //拼接完整的主题包路径
   NSString *path = [resPath  stringByAppendingPathComponent:pathSufix];
    
   return  path;
    
}


@end
