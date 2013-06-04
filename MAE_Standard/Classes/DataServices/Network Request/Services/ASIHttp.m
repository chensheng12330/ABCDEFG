//
//  ASIHttp.m
//  Template
//
//  Created by Knife on 13-1-3.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "ASIHttp.h"

@implementation ASIHttp

@synthesize userInfo = _userInfo;
@synthesize error = _error;
@synthesize url = _url;
@synthesize responseString = _responseString;
@synthesize requestMethod = _requestMethod;
@synthesize headValueDictionary = _headValueDictionary;
@synthesize postValueDictionary = _postValueDictionary;
@synthesize getValueDictionary = _getValueDictionary;
@synthesize responseData = _responseData;

// 使用一个URL初始化对象
- (id)initWithURL:(NSURL *)newURL
{
    self = [super init];
    
    if ( nil != self ) {
        self.url = newURL;
    }
    
    return self;
}

// 启动一个同步请求
- (void) startSynchronous
{
    NSString *headStr = @"";
    NSString *getpstr = @"";
    
    // 添加GET参数
    if ( [self.getValueDictionary count] != 0 ) {
        
        NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
        getpstr = @"?";
        
        // 创建url参数
        for ( NSString *key in [self.getValueDictionary allKeys] ) {
            
            headStr = [self.getValueDictionary objectForKey:key];
            
            if ( ![headStr isKindOfClass:[NSString class]] ) {
                headStr = [NSString stringWithFormat:@"%@", headStr];
            }
            
            getpstr = [NSString stringWithFormat:@"%@&%@=%@", getpstr, key, headStr];
        }
        
        NSString *string = [NSString stringWithFormat:@"%@%@", self.url, getpstr];
        NSURL *gurl = [NSURL URLWithString:string];
        self.url = gurl;
        
        [autoreleasePool release];
    }
    
    // 创建Http请求对象
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:self.url];
    
    // 设置请求方式
    if ( [self.requestMethod length] != 0 ) {
        [requestForm setRequestMethod:self.requestMethod];
    }
    
    // 添加Post参数
    for ( NSString *key in [self.postValueDictionary allKeys] ) {
        
        headStr = [self.postValueDictionary objectForKey:key];
        
        if ( ![headStr isKindOfClass:[NSString class]] ) {
            headStr = [NSString stringWithFormat:@"%@", headStr];
        }
        
        [requestForm setPostValue:headStr forKey:key];
        
    }
    
    // 添加头部参数
    for ( NSString *key in [self.headValueDictionary allKeys] ) {
        
        headStr = [self.headValueDictionary objectForKey:key];
        
        if ( ![headStr isKindOfClass:[NSString class]] ) {
            headStr = [NSString stringWithFormat:@"%@", headStr];
        }
        
        [requestForm addRequestHeader:key value:headStr];
    }
    
    // 同步请求网络数据
    [requestForm startSynchronous];
    
    // 获取错误对象
    self.error = [requestForm error];
    
    if ( self.error == nil )
    { 
        // 转换编码方法
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
        
        [_responseString release];
        
        // 创建UTF编码对象
        _responseString = [[NSString alloc] initWithData:[requestForm responseData] encoding:enc];

    }
    
    [requestForm release];
}

// 获取返回的响应的字符串
- (NSString*) responseString
{
    return _responseString;
}

// 添加一个Post请求参数
- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key
{
    if ( value != nil && key != nil ) {
        [self.postValueDictionary setObject:value forKey:key];
    }

}

// 添加一个Post请求参数，如果存在则将之前设置的值清楚
- (void)setPostValue:(id <NSObject>)value forKey:(NSString *)key
{
    if ( value != nil && key != nil ) {
        [self.postValueDictionary removeObjectForKey:key];
        
        [self addPostValue:value forKey:key];
    }
    
}

// 添加一个Get请求参数
- (void)addGetValue:(id<NSObject>)value forKey:(NSString *)key
{
    if ( value != nil && key != nil ) {
        [self.getValueDictionary setObject:value forKey:key];
    }

}

// 添加一个Get请求参数，如果存在则将之前设置的值清楚
- (void)setGetValue:(id<NSObject>)value forKey:(NSString *)key
{
    if ( value != nil && key != nil ) {
        [self.getValueDictionary removeObjectForKey:key];
        [self addGetValue:value forKey:key];
    }
}

// 添加一个head请求参数
- (void)addHeadValue:(id<NSObject>)value forKey:(NSString *)key
{
    if ( value != nil && key != nil ) {
        [self.headValueDictionary setObject:value forKey:key];
    }

}

// 添加一个Head请求参数，如果存在则将之前设置的值清楚
- (void)setHeadValue:(id<NSObject>)value forKey:(NSString *)key
{
    if ( value != nil && key != nil ) {
        
        [self.headValueDictionary removeObjectForKey:key];
        
        [self addHeadValue:value forKey:key];
    }
    
}

// 返回Post对象字典
- (NSMutableDictionary*) postValueDictionary
{
    if ( nil == _postValueDictionary ) {
        _postValueDictionary = [[NSMutableDictionary alloc] init];
    }
    return _postValueDictionary;
}

- (NSMutableDictionary*) headValueDictionary
{
    if ( nil == _headValueDictionary ) {
        _headValueDictionary = [[NSMutableDictionary alloc] init];
    }
    return _headValueDictionary;
}

- (NSMutableDictionary*) getValueDictionary
{
    if ( nil == _getValueDictionary ) {
        _getValueDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _getValueDictionary;
}

- (void)dealloc
{
    [_responseData release];
    [_requestMethod release];
    [_error release];
    [_url release];
    [_responseString release];
    [_userInfo release];
    [_postValueDictionary release];
    [_headValueDictionary release];
    [_getValueDictionary release];
    [super dealloc];
}

@end
