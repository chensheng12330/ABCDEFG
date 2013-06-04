//
//  ArchiverCacheDB.h
//  Template
//
//  Created by Knife on 13-1-3.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

// 用归档实现的数据存储

#import <Foundation/Foundation.h>
#import "Interface.h"

// 缓存文件的存储路径
#define CACHEPATH       @"/Library/Caches/"


// 缓存文件名
#define CACHEFILENAME   @"CacheDB.bin"


@interface ArchiverCacheDB : NSObject <CacheDBInterface>
{
    NSMutableDictionary *cacheTable;        // 存储数据的表 key --- Record
    NSRecursiveLock *cacheTableLock;        // 线程互斥锁
}

@end
