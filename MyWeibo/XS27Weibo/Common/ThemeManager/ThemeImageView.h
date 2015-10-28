
#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView
@property (nonatomic,copy) NSString *imageName;//图片名字

@property (nonatomic,assign)CGFloat leftCap; //拉伸点
@property (nonatomic,assign)CGFloat topCap;

@end
