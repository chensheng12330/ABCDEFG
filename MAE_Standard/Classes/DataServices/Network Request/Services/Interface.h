//
//  Interface.h
//  Template
//
//  Created by Knife on 13-1-3.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#ifndef Template_Interface_h
#define Template_Interface_h

@protocol HttpInterface;
@protocol HttpAsynHandleInterface;
@protocol CacheDBInterface;
@protocol HttpAsynInterface;
@protocol HttpSynInterface;


typedef id<HttpInterface> HttpInterface;
typedef id<HttpAsynHandleInterface> HttpAsynHandleInterface;
typedef id<CacheDBInterface> CacheDBInterface;
typedef id<HttpAsynInterface> HttpAsynInterface;
typedef id<HttpSynInterface> HttpSynInterface;

@protocol HttpAsynHandleInterface <NSObject>

// 开始请求网络
- (void)requestStarted:(id<HttpInterface>) httpInterface;

// 请求完成，并且成功
- (void)requestFinished:(id<HttpInterface>) httpInterface;

// 请求网络失败
- (void)requestFailed:(id<HttpInterface>) httpInterface;

@end


//  Http协议处理接口
@protocol HttpInterface <NSObject>

@property (nonatomic, retain) NSURL *url;                                       // 设置URL
@property (nonatomic, retain) NSError *error;                                   // 当前错误信息
@property (nonatomic, retain) NSObject *userInfo;                               // 用户自定义数据
@property (nonatomic, readonly) NSString *responseString;                       // 网络字符
@property (nonatomic, readonly) NSData *responseData;                           // 网络二进制数据
@property (nonatomic, retain) NSString *requestMethod;                          // 请求方式

// 使用一个URL初始化对象
- (id)initWithURL:(NSURL *)newURL;

// 获取返回的响应的字符串
- (NSString*) responseString;

// 添加一个Post请求参数
- (void)addPostValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个Post请求参数，如果存在则将之前设置的值清楚
- (void)setPostValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个Get请求参数
- (void)addGetValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个Get请求参数，如果存在则将之前设置的值清楚
- (void)setGetValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个head请求参数
- (void)addHeadValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个Head请求参数，如果存在则将之前设置的值清楚
- (void)setHeadValue:(id<NSObject>)value forKey:(NSString *)key;

@end

// Http协议的异步处理接口
@protocol HttpAsynInterface <HttpInterface>

@property (nonatomic, assign) id<HttpAsynHandleInterface> asynHandleInterface;  // 异步处理接口

// 启动一个异步请求
- (void) startAsynchronous;

@end

// Http协议的同步处理接口
@protocol HttpSynInterface <HttpInterface>

// 启动一个同步请求
- (void) startSynchronous;

@end


// 数据存储接口
@protocol CacheDBInterface <NSObject>

- (NSString*) objectForKey:(NSString*) key;

- (void) addCacheRecord:(NSString*)responseValue forKey:(NSString *)key;

@end


#endif
