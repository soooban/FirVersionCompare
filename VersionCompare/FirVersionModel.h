//
//  FirVersionModel.h
//  VersionCompare
//
//  Created by Parsifal on 15/1/21.
//  Copyright (c) 2015年 huaban. All rights reserved.
//

#import "JSONModel.h"

@interface FirVersionModel : JSONModel

//version	版本号
//versionShort	可读版本号
//update_url	升级地址
//changelog	更新日志

@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *versionShort;
@property (strong, nonatomic) NSString *update_url;
@property (strong, nonatomic) NSString *changelog;


@end
