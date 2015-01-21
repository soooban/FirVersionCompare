//
//  VersionCompare.m
//  VersionCompare
//
//  Created by Parsifal on 15/1/20.
//  Copyright (c) 2015年 huaban. All rights reserved.
//

#import "FirVersionCompare.h"
#import <AFNetworking/AFNetworking.h>
#import "FirVersionModel.h"

#define kBASE_URL @"http://fir.im/api/v2/app/version/"

@interface FirVersionCompare ()

@property (strong, nonatomic) NSString *update_url;

@end

@implementation FirVersionCompare

+ (instancetype)sharedInstance
{
    static FirVersionCompare *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)compareVersionWithAppKey:(NSString *)key
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"%@%@", kBASE_URL, key];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *responseDic = responseObject;
        NSError *error = nil;
        FirVersionModel *versionModel = [[FirVersionModel alloc] initWithDictionary:responseDic error:&error];
        if (error) {
            NSLog(@"Dictionary -> Model Failed");
            return;
        }
        self.update_url = versionModel.update_url;
        NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];

        if ([versionModel.versionShort compare:localVersion options:NSNumericSearch] == NSOrderedDescending) {
            NSString *alertText = [NSString stringWithFormat:@"远程版本:%@ 本地版本:%@ 更新内容:%@ 是否更新?", versionModel.versionShort, localVersion, versionModel.changelog];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertText delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Version Check Error: %@", error);
    }];
}

#pragma mark - Alert Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.update_url]];
}
@end
