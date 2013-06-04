//
//  InstanceFactory.h
//  Template
//
//  Created by Knife on 13-1-4.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

// 工厂类，用来创建可配置的抽象类

#import <Foundation/Foundation.h>
#import "Interface.h"

@interface InstanceFactory : NSObject


// 获取用来处理http协议的类对象
+ (id<HttpInterface>) getHttpInterface;

// 获取用来同步方法处理http协议的类对象
+ (id<HttpSynInterface>) getHttpSynInterface;

// 获取用来存储数据的类对象
+ (id<CacheDBInterface>) getCacheDBInterface;


@end
