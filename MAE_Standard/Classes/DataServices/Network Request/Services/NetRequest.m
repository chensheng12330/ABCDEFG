//
//  NetRequest.m
//  Template
//
//  Created by Knife on 13-1-1.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "NetRequest.h"
#import "JSONKit.h"
#import "ServicesConfig.h"

@implementation NetRequest

@synthesize requestTypeKey;
@synthesize userInfo;
@synthesize handleInterface = _handleInterface;
@synthesize netResponse = _netResponse;
@synthesize tag = _tag;
@synthesize requestURL = _requestURL;
@synthesize isSerialize;
@synthesize requestMethod;
@synthesize parameterEntity = _parameterEntity;

- (id) init
{
    self = [super init];
    
    if ( nil != self ) {
        
        // 默认位POST请求方式
        requestMethod = @"POST";
    }
    
    return self;
}

// 获当前请求的唯一标示（请求地址加上请求参数）
- (NSString*) getKey
{
    return @"knife";
}

- (ParameterEntity*) parameterEntity
{
    if ( nil == _parameterEntity ) {
        _parameterEntity = [[ParameterEntity alloc] init];
    }
    
    return _parameterEntity;
}


// 获得当前请求的API地址
- (NSURL*) requestURL
{

    NSString *string = [NSString stringWithFormat:@"%@", APISERVER];
    
    // 从配置器中根据请求接口类型，初始化请求接口
    if ( self.requestTypeKey != nil ) {
        
        // 获取API接口服务器
        NSString *apiURL = [SC getAPIServerURL];
        
        // 根据接口类型，获取API接口地址
        NSString *url = [SC getAPIURLForType:self.requestTypeKey];
        
        // 创建API接口
        string = [NSString stringWithFormat:@"%@%@", apiURL, url];
    }
    
    return [NSURL URLWithString:string];

}

- (NSString*) requestMethod {
    
    // 从配置器中获取当前接口的请求方式，默认是POST
    NSString *method = [SC getRequestMethodForType:self.requestTypeKey];
    
    if ( method == nil || method.length == 0 ) {
        return requestMethod;
    }
    
    return method;
}

- (void)dealloc
{
    [_parameterEntity release];
    [requestMethod release];
    [userInfo release];
    [_requestURL release];
    [super dealloc];
}

@end




@implementation ParameterEntity

@synthesize headDictionary = _headDictionary;
@synthesize postDictionary = _postDictionary;
@synthesize getDictionary = _getDictionary;

// 添加一个Post请求参数
- (void) setPostValue:(id<NSObject>)value forKey:(NSString *)key
{
    [self setValue:value forKey:key forMethod:@"POST"];
}

// 添加一个Get请求参数
- (void) setGetValue:(id<NSObject>)value forKey:(NSString *)key
{
    [self setValue:value forKey:key forMethod:@"GET"];
}

// 添加一个Head请求参数
- (void) setHeadValue:(id<NSObject>)value forKey:(NSString *)key
{
    [self setValue:value forKey:key forMethod:@"HEAD"];
}

// 添加一个参数
- (void) setValue:(id<NSObject>)value forKey:(NSString *)key forMethod:(NSString*) method
{
    NSMutableDictionary *tempTable = nil;
    
    if ( [method isEqualToString:@"POST"] ) {
        tempTable = self.postDictionary;
    } else if ( [method isEqualToString:@"GET"] ) {
        tempTable = self.getDictionary;
    } else if ( [method isEqualToString:@"HEAD"] ) {
        tempTable = self.headDictionary;
    }
    
    if ( key != nil && value != nil ) {
        [tempTable setObject:value forKey:key];
    }
}

- (NSMutableDictionary*) headDictionary
{
    if ( nil == _headDictionary ) {
        _headDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _headDictionary;
}

- (NSMutableDictionary*) getDictionary
{
    if ( nil == _getDictionary ) {
        _getDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _getDictionary;
}

- (NSMutableDictionary*) postDictionary
{
    if ( nil == _postDictionary ) {
        _postDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _postDictionary;
}

- (void)dealloc
{
    [_postDictionary release];
    [_getDictionary release];
    [_headDictionary release];
    [super dealloc];
}

@end




