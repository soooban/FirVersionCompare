//
//  VersionCompare.m
//  VersionCompare
//
//  Created by 周国勇 on 15/1/20.
//  Copyright (c) 2015年 huaban. All rights reserved.
//

#import "FirVersionCompare.h"
#import "UIAlertView+BlocksKit.h"

#define kBASE_URL @"http://api.fir.im/apps/latest/"

@implementation FirVersionCompare

+ (void)compareVersionWithApiKey:(NSString *)key
{
    NSOperationQueue *mainQueue = [[NSOperationQueue alloc] init];
    [mainQueue setMaxConcurrentOperationCount:1];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBASE_URL, key];

    // Create the request.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc ]initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];

    [NSURLConnection sendAsynchronousRequest:request queue:mainQueue completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
        if (!error) {
            if (urlResponse.statusCode != 200) {
                return;
            }
            NSError *error = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
            if (error) {
                NSLog(@"Data -> JSONObject Failed With Error : %@", error.localizedDescription);
            }else{
                NSString *remoteVersion = responseDictionary[@"versionShort"];
                NSString *remoteBuild = responseDictionary[@"version"];
                NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                NSString *localBuild = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
                NSString *changelog = responseDictionary[@"changelog"];
                NSString *update_url = responseDictionary[@"update_url"];
                if ([remoteVersion compare:localVersion options:NSNumericSearch] == NSOrderedDescending||
                    ([remoteVersion compare:localVersion options:NSNumericSearch] == NSOrderedSame&&
                     [remoteBuild compare:localBuild options:NSNumericSearch] == NSOrderedDescending)) {
                    NSString *message = [NSString stringWithFormat:@"Latest: %@ (%@) Current: %@ (%@) Changelog:%@ Update?", remoteVersion,remoteBuild, localVersion,localBuild, changelog];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIAlertView bk_showAlertViewWithTitle:@"New Version is available"
                                                       message:message
                                             cancelButtonTitle:@"Cancel"
                                             otherButtonTitles:@[@"Download"]
                                                       handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                                           if (buttonIndex == 1) {
                                                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:update_url]];
                                                           }
                                                       }];
                    });
                }
            }
            
            NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
        else {
            NSLog(@"An error occured, Status Code: %ld", (long)urlResponse.statusCode);
            NSLog(@"Description: %@", [error localizedDescription]);
            NSLog(@"Response Body: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
        }
    }];

}

@end
