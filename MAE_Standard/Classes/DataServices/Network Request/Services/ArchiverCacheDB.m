//
//  ArchiverCacheDB.m
//  Template
//
//  Created by Knife on 13-1-3.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "ArchiverCacheDB.h"

@implementation ArchiverCacheDB

- (NSString*) objectForKey:(NSString*) key
{
    return [cacheTable objectForKey:key];
}

- (void) addCacheRecord:(NSString*)value forKey:(NSString *)key
{
    if ( [cacheTable objectForKey:key] != nil ) {
        [cacheTable removeObjectForKey:key];
    }
    
    [cacheTable setObject:value forKey:key];
}


/**
 @method 将缓存中的数据存储到文件中
 */
- (void) serialize
{
    [cacheTableLock lock];
        
    // 确定归档路径
    NSString *homepath = NSHomeDirectory();
	NSString *serializepath = [homepath stringByAppendingFormat:@"%@%@", CACHEPATH, CACHEFILENAME];
    
    [cacheTable writeToFile:serializepath atomically:YES];
    
    [cacheTableLock unlock];
}

/**
 @method 从文件读取数据对象
 */
- (void) deSerialize
{
    [cacheTableLock lock];
    
    // 确定文件路径
    NSString *homepath = NSHomeDirectory();
	NSString *serializepath = [homepath stringByAppendingFormat:@"%@%@", CACHEPATH, CACHEFILENAME];
    
    [cacheTable release];
    
    cacheTable = [[NSMutableDictionary alloc] initWithContentsOfFile:serializepath];
    
    if ( nil == cacheTable ) {
        cacheTable = [[NSMutableDictionary alloc] init];
    }
    
    [cacheTableLock unlock];
}

- (void)dealloc
{
    [cacheTable release];
    [cacheTableLock release];
    [super dealloc];
}

@end
