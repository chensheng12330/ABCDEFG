//
//  NetResponse.h
//  Template
//
//  Created by Knife on 13-1-1.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfig.h"

// 网络响应数据来源
typedef enum {
    eNetResponseFromNetWork,      // 来源网络
    eNetResponseFromCache,        // 缓存
    eNetResponseFromDisk          // 磁盘
}NetResponseFromType;

@interface NetResponse : NSObject
{
    NSDictionary *_responseDictionary;          // 解析JSON后的字典对象
    NSString *_serializeJsonString;              // 序列化的JSON串
    NetResponseFromType _netResponseFromType;   // 网络响应数据来源
}

@property (nonatomic, readonly) NSDictionary *responseDictionary;
@property (nonatomic, assign) NetResponseFromType netResponseFromType;
@property (nonatomic, readonly) NSString *serializeJsonString;

- (id) initWithJson:(NSString*) jsonString;

- (id) objectForKey:(NSString*) key;

@end
