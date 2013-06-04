//
//  ServicesConfig.h
//  Evercare
//
//  Created by Knife on 13-5-13.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ePlist,             // plist文件内容
    eJson,              // json数据
    ePlistFilePath,     // plist文件路径
    eJsonFilePath       // json文件路径
}XDataType;

@interface ServicesConfig : NSObject

// 初始化配置器
+ (void) initServicesConfig;

// 获取默认的Services配置器
+ (ServicesConfig*) defaultServicesConfig;

// 初始化配置器
- (void) initWithData:(NSString*) data ofType:(XDataType) datatype;

// 获得APP的配置参数字典
- (NSDictionary*) getConfigDictionary;

// 获得所有的API接口字典
- (NSDictionary*) getAPIDictionary;

// 获取API的必填参数字典
- (NSDictionary*) getNecessaryDictionary;

// 获得一个接口的后缀URL地址
- (NSString*) getAPIURLForType:(NSString*) type;

// 获得一个接口的http请求类型
- (NSString*) getRequestMethodForType:(NSString*) type;

// 获得API的服务器地址
- (NSString*) getAPIServerURL;

@end


#define SC [ServicesConfig defaultServicesConfig] 


