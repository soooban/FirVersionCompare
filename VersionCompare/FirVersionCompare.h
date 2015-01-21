//
//  VersionCompare.h
//  VersionCompare
//
//  Created by Parsifal on 15/1/20.
//  Copyright (c) 2015年 huaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirVersionCompare : NSObject<UIAlertViewDelegate>

- (void)compareVersionWithAppKey:(NSString *)key;

+ (instancetype)sharedInstance;

@end
