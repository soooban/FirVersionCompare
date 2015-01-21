# FirVersionCompare

基于fir.im应用分发网站的Version Compare 工具类

![Screen Shot](./screen shot.png)

## 使用
### CocoaPods安装
	pod 'FirVersionCompare', :git => 'https://github.com/jokefaker/FirVersionCompare.git'
### 代码
	#import "FirVersionCompare.h"

	@interface AppDelegate ()

	@end

	@implementation AppDelegate

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    	// Override point for customization after application launch.
    	[FirVersionCompare compareVersionWithAppKey:@"54894d31d408a67b03001724"];
    	return YES;
	}    
详细见FirVersionCompareDemo

## 注意

* iOS7 +