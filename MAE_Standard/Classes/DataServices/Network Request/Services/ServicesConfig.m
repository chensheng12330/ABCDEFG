//
//  ServicesConfig.m
//  Evercare
//
//  Created by Knife on 13-5-13.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "ServicesConfig.h"
#import "JSONKit.h"


#define APIKEY          @"API"
#define CONFIGKEY       @"Config"
#define NECESSARYKEY    @"Necessary"

#define API_URL         @"apiurl"
#define API_METHOD      @"requestMethod"

#ifdef XDEBUG
#define APISERVERURLKEY @"apiserverurl_debug"
#else
#define APISERVERURLKEY @"apiserverurl_release"
#endif

static ServicesConfig *static_servicesConfig;
static NSDictionary *static_configDic;

@implementation ServicesConfig

// 初始化配置器
+ (void) initServicesConfig
{
    ServicesConfig *sc = [ServicesConfig defaultServicesConfig];
    [sc initWithData:@"servicesConfig.plist" ofType:ePlistFilePath];
    
}

// 获取默认的Services配置器
+ (ServicesConfig*) defaultServicesConfig
{
    @synchronized( self ) {
        if( nil == static_servicesConfig ) {
            static_servicesConfig = [[ServicesConfig alloc] init];
        }
    }
    
    return static_servicesConfig;
}

// 初始化配置器
- (void) initWithData:(NSString*) data ofType:(XDataType) datatype
{
    NSDictionary *dicObj = nil;
    
    switch ( datatype ) {
        case ePlistFilePath:
        {
            NSString *strPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:data];
            dicObj = [[NSDictionary alloc] initWithContentsOfFile:strPath];
            break;
        }
        case eJson:
        {
            NSDictionary *tempObj = [data objectFromJSONString];
            dicObj = [tempObj retain];
            break;
        }
        case eJsonFilePath:
        {
            NSString *strPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:data];
            NSString *jsontext = [NSString stringWithContentsOfFile:strPath encoding:NSUTF8StringEncoding error:nil];
            NSDictionary *tempObj = [jsontext objectFromJSONString];
            dicObj = [tempObj retain];
            break;
        }
        case ePlist:
        {
            break;
        }
        default:
            break;
    }
    
    if ( dicObj != nil && [self isCorrect:dicObj] ) {
        
        [static_configDic release];
        static_configDic = [dicObj retain];
    }
    
    [dicObj release];
    
}

// 获得APP的配置参数字典
- (NSDictionary*) getConfigDictionary
{
    return [static_configDic objectForKey:CONFIGKEY];;
}

// 获得所有的API接口字典
- (NSDictionary*) getAPIDictionary
{
    return [static_configDic objectForKey:APIKEY];
    return nil;
}

// 获取API的必填参数字典
- (NSDictionary*) getNecessaryDictionary
{
    return [static_configDic objectForKey:NECESSARYKEY];
}

// 获得一个接口的后缀URL地址
- (NSString*) getAPIURLForType:(NSString*) type
{
    NSDictionary *apiDic = [[self getAPIDictionary] objectForKey:type];
    
    if ( [apiDic isKindOfClass:[NSDictionary class]] ) {
        
        NSString *urlstring = [apiDic objectForKey:API_URL];
        
        if ( [urlstring isKindOfClass:[NSString class]] ) {
            return urlstring;
        }
    }
    
    return nil;
}

// 获得一个接口的http请求类型
- (NSString*) getRequestMethodForType:(NSString*) type
{
    NSDictionary *apiDic = [[self getAPIDictionary] objectForKey:type];
    
    if ( [apiDic isKindOfClass:[NSDictionary class]] ) {
        
        NSString *methodstring = [apiDic objectForKey:API_METHOD];
        
        if ( [methodstring isKindOfClass:[NSString class]] ) {
            return methodstring;
        }
    }
    
    return nil;
}

// 获得API的服务器地址
- (NSString*) getAPIServerURL
{    
    NSDictionary *configobj = [self getConfigDictionary];
    NSString *string = [configobj objectForKey:APISERVERURLKEY];
    return string;
}

// 判断字典是否是需要的字典结构
- (BOOL) isCorrect:(NSDictionary*) dicObj
{
    if ( ![dicObj isKindOfClass:[NSDictionary class]] ) {
        return NO;
    }
    
    id apiobj = [dicObj objectForKey:APIKEY];
    id configobj = [dicObj objectForKey:CONFIGKEY];
    id necessaryobj = [dicObj objectForKey:NECESSARYKEY];
    
    return apiobj != nil && configobj != nil && necessaryobj != nil;
    
}

@end
