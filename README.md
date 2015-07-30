# FirVersionCompare

Version Comparing in FIR.im

![Screen Shot](./screen shot.png)

## Installation
### CocoaPods
	pod 'FirVersionCompare', :git => 'https://github.com/harryworld/FirVersionCompare.git'
### Code
```Objective-C
	#import "FirVersionCompare.h"

	@interface AppDelegate ()

	@end

	@implementation AppDelegate

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    	// Override point for customization after application launch.
    	[FirVersionCompare compareVersionWithApiKey:@"54894d31d408a67b03001724"];
    	return YES;
	}
```
Reference in FirVersionCompareDemo

## Remarks

* iOS7 +

## Updates
* 2015-07-15 Supports apikey
