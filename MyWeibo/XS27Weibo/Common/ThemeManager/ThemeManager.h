

#import <Foundation/Foundation.h>

#define kThemeNameDidChangedNotification  @"kThemeNameDidChangeNotification"
#define kThemeName @"kThemeName"

@interface ThemeManager : NSObject

//默认主题名字
@property (nonatomic,copy) NSString *themeName;

//单例方法
+ (ThemeManager *)shareInstance;

- (UIImage *)getThemeImage:(NSString *)imageName;
- (UIColor *)getThemeColor:(NSString *)colorName;



@end
