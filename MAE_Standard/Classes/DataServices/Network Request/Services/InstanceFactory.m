//
//  InstanceFactory.m
//  Template
//
//  Created by Knife on 13-1-4.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "InstanceFactory.h"
#import "ASIHttp.h"
#import "ArchiverCacheDB.h"

@implementation InstanceFactory


// 获取用来处理http协议的类对象
+ (id<HttpInterface>) getHttpInterface
{
    HttpInterface asiHttp = [[ASIHttp alloc] init];

    return [asiHttp autorelease];
}

// 获取用来同步处理http协议的类对象
+ (id<HttpSynInterface>) getHttpSynInterface
{
    HttpSynInterface asiHttp = [[ASIHttp alloc] init];
    
    return [asiHttp autorelease];
}

// 获取用来存储数据的类对象
+ (id<CacheDBInterface>) getCacheDBInterface
{
    static ArchiverCacheDB *archiverCacheDB = nil;
    
    if ( archiverCacheDB == nil ) {
        archiverCacheDB = [[[ArchiverCacheDB alloc] init] autorelease];
    }
    return archiverCacheDB;
}

@end
