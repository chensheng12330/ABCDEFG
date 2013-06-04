//
//  NetRequest.h
//  Template
//
//  Created by Knife on 13-1-1.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetConfig.h"
#import "NetResponse.h"

@class NetRequest;
@class ParameterEntity;

@protocol HandleRequestInterface;

typedef id<HandleRequestInterface> HandleRequestInterface;

// 网络请求异步完成接口
@protocol HandleRequestInterface <NSObject>

// 网络请求成功
-(void)requestDone:(NetRequest*) netRequest UserInfo:(NSObject*) userInfo;

// 网络请求失败
-(void)requestFailed:(NetRequest*) netRequest Error:(NSError*)error UserInfo:(NSObject*) userInfo;

@end

@interface NetRequest : NSObject
{
    NetResponse *_netResponse;                      // 该请求对象的对应的http响应对象
    id<HandleRequestInterface> _handleInterface;    // 请求完成处理对象
    int _tag;                                       // 对象标识
    NSObject *_userInfo;                            // 用户自定义结构
    NSURL *_requestURL;                             // 请求的网络地址
    BOOL isSerialize;                               // 是否序列化该请求
    
    NSString *requestTypeKey;                       // 请求类型的Key，通过service管理器进行参数的设定
    ParameterEntity *_parameterEntity;              // 当前请求的参数对象
}

@property (nonatomic, retain) NSString *requestTypeKey;
@property (nonatomic, retain) NetResponse *netResponse;
@property (nonatomic, assign) id<HandleRequestInterface> handleInterface;
@property (nonatomic, retain) NSObject *userInfo;
@property (nonatomic, assign) int tag;
@property (nonatomic, readonly) NSURL *requestURL;
@property (nonatomic, assign) BOOL isSerialize;

@property (nonatomic, retain) NSString *requestMethod;
@property (nonatomic, readonly) ParameterEntity *parameterEntity;

// 获得当前请求对像的唯一标识
- (NSString*) getKey;

@end


// 网络请求的参数实体类，封装参数
@interface ParameterEntity : NSObject
{
    NSMutableDictionary *_postDictionary;           // 提交的表单数据
    NSMutableDictionary *_headDictionary;           // 提交的头数据
    NSMutableDictionary *_getDictionary;            // GET方式的参数
}

@property (nonatomic, readonly) NSMutableDictionary *postDictionary;
@property (nonatomic, readonly) NSMutableDictionary *headDictionary;
@property (nonatomic, readonly) NSMutableDictionary *getDictionary;

// 添加一个Post请求参数
- (void) setPostValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个Get请求参数
- (void) setGetValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个Head请求参数
- (void) setHeadValue:(id<NSObject>)value forKey:(NSString *)key;

// 添加一个参数
- (void) setValue:(id<NSObject>)value forKey:(NSString *)key forMethod:(NSString*) method;

@end
