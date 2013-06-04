//
//  NetWorkServices.m
//  Template
//
//  Created by Knife on 13-1-1.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "NetWorkServices.h"
#import "Interface.h"
#import "NetRequest.h"
#import "NetResponse.h"
#import "InstanceFactory.h"

@interface ThreadEvnEntity : NSObject

@property (nonatomic, retain) NetRequest *netRequest;
@property (nonatomic, retain) NSObject *userInfo;

@end

@implementation ThreadEvnEntity

@synthesize netRequest;
@synthesize userInfo;

- (void)dealloc
{
    [netRequest release];
    [userInfo release];
    [super dealloc];
}

@end


static NetWorkServices *static_netWorkServices = nil;
static NSMutableArray *static_threadEvnInfo = nil;


@implementation NetWorkServices

+ (NetWorkServices*) defaultNetWorkServices
{
    @synchronized( self ) {
        if( nil == static_netWorkServices ) {
            static_netWorkServices = [[NetWorkServices alloc] init];
            static_threadEvnInfo = [[NSMutableArray alloc] init];
        }
    }
    
    return static_netWorkServices;
}

// 发送一个异步网络请求
// 请求对象
// 发送成功返回YES，否则NO
- (BOOL) sendRequest:(NetRequest*) netRequest                   // 请求对象
            UserInfo:(NSObject*) userInfo
{
    ThreadEvnEntity *threadEvnInfo = [[ThreadEvnEntity alloc] init];
    
    threadEvnInfo.userInfo = userInfo;
    threadEvnInfo.netRequest = netRequest;
    
    [static_threadEvnInfo addObject:threadEvnInfo];
    
    [self performSelectorInBackground:@selector(_sendRequest:) withObject:threadEvnInfo];
    
    [threadEvnInfo release];
    
    return YES;
}


// 子线程入口函数，执行网络请求
// 请求对象
// 发送成功返回YES，否则NO
- (void) _sendRequest:(ThreadEvnEntity*) threadEvnInfo
{
    if ( [static_threadEvnInfo count] == 0 || threadEvnInfo == nil ) {
        return;
    }
    
    NSAutoreleasePool *autoreleasePool = [[NSAutoreleasePool alloc] init];
    
    [self synSendRequest:threadEvnInfo];
    
    [static_threadEvnInfo removeObject:threadEvnInfo];
    
    [autoreleasePool release];
}

// 从网络请求数据
- (void) synSendRequest:(ThreadEvnEntity*) threadEvnEntity
{
    // 获取一个http请求接口对象
    HttpSynInterface httpSynInterface = [InstanceFactory getHttpSynInterface];
    HttpInterface httpInterface = httpSynInterface;
    
    // 获取http请求完成后的事件监听者
    HandleRequestInterface handleRequestInterface = threadEvnEntity.netRequest.handleInterface;
    
    // 获取主线程对象
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 开始发送http请求（未设置参数）
    [self startSendNetRequest:threadEvnEntity.netRequest ProgressStat:eStart additionInfo:nil];
    
    // 设置http请求地址
    httpInterface.url = threadEvnEntity.netRequest.requestURL;
    
    // 设置http请求方式：GET POST
    [httpSynInterface setRequestMethod:threadEvnEntity.netRequest.requestMethod];
    
    // 设置http Post请求参数
    for (NSString *key in [threadEvnEntity.netRequest.parameterEntity.postDictionary allKeys] ) {
        
        id<NSObject> value = [threadEvnEntity.netRequest.parameterEntity.postDictionary objectForKey:key];
        
        [httpInterface addPostValue:value forKey:key];
        
    }
    
    // 设置http Get请求参数
    for (NSString *key in [threadEvnEntity.netRequest.parameterEntity.getDictionary allKeys] ) {
        
        id<NSObject> value = [threadEvnEntity.netRequest.parameterEntity.getDictionary objectForKey:key];
        
        [httpInterface addGetValue:value forKey:key];
        
    }
    
    // 设置http头部信息
    for ( NSString *key in [threadEvnEntity.netRequest.parameterEntity.headDictionary allKeys] ) {
        
        id<NSObject> value = [threadEvnEntity.netRequest.parameterEntity.headDictionary objectForKey:key];
        
        [httpInterface addHeadValue:value forKey:key];
    }
    
    // 参数设置完成
    [self startSendNetRequest:threadEvnEntity.netRequest ProgressStat:eDoneParameter additionInfo:nil];
    
    // 发起http同步请求，获取网络数据
    [httpSynInterface startSynchronous];
    
    // http请求发送完成
    [self startSendNetRequest:threadEvnEntity.netRequest ProgressStat:eDoneRequest additionInfo:httpInterface.responseString];
    
    // 如果没有监听者则不进一步处理
    if ( nil == handleRequestInterface ) {
        return;
    }

    if ( httpInterface.error != nil ) {

        // http请求失败
        dispatch_sync(mainQueue, ^{
            [handleRequestInterface requestFailed:threadEvnEntity.netRequest Error:httpInterface.error UserInfo:threadEvnEntity.userInfo];
        });
        
    } else {
        
        // 创建响应对象
        NetResponse *netResponse = [[NetResponse alloc] initWithJson:httpInterface.responseString];
        
        // 设置数据来源
        netResponse.netResponseFromType = eNetResponseFromNetWork;
        
        // 设置请求对象的响应对象
        threadEvnEntity.netRequest.netResponse = netResponse;
        
        // 在主线程中通知
        dispatch_sync(mainQueue, ^{
            // 通知外层处理
            [handleRequestInterface requestDone:threadEvnEntity.netRequest UserInfo:threadEvnEntity.userInfo];
        });
        
        // 存储当前请求
        if ( threadEvnEntity.netRequest.isSerialize ) {
            
            // 获取存储对象
            CacheDBInterface cacheDBInterface = [InstanceFactory getCacheDBInterface];
            
            // 保存当前请求
            [cacheDBInterface addCacheRecord:httpInterface.responseString forKey:[threadEvnEntity.netRequest getKey]];
        }

        [netResponse release];
    }
}

// 从硬盘中读取数据
- (void) synSendRequestFormDisk:(ThreadEvnEntity*) threadEvnEntity
{
    // 获取存储对象
    CacheDBInterface cacheDBInterface = [InstanceFactory getCacheDBInterface];
    HandleRequestInterface handleRequestInterface = threadEvnEntity.netRequest.handleInterface;
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 从数据库中取出数据
    NSString *jsonString = [cacheDBInterface objectForKey:[threadEvnEntity.netRequest getKey]];
    
    if ( nil == jsonString || [jsonString length] == 0 ) {
        
        // 在主线程中通知
        dispatch_sync(mainQueue, ^{
            // 通知外层处理
            [handleRequestInterface requestFailed:threadEvnEntity.netRequest Error:nil UserInfo:threadEvnEntity.userInfo];
        });
    } else {
        // 创建响应对象
        NetResponse *netResponse = [[NetResponse alloc] initWithJson:jsonString];
        
        // 设置数据来源
        netResponse.netResponseFromType = eNetResponseFromDisk;
        
        // 设置请求对象的响应对象
        threadEvnEntity.netRequest.netResponse = netResponse;
        
        // 在主线程中通知
        dispatch_sync(mainQueue, ^{
            // 通知外层处理
            [handleRequestInterface requestDone:threadEvnEntity.netRequest UserInfo:threadEvnEntity.userInfo];
        });
        
        [netResponse release];
    }
}


- (NSObject*) startSendNetRequest:(NetRequest*) netRequest                   // 正在出来的NetRequest对象
                     ProgressStat:(XProgressStat) stat                       // 当前进度状态
                     additionInfo:(NSObject*) additionInfo                   // 附加参数，不同进度状态下，参数值有所不同
{
    
    for ( id<NetWorkServicesInterface> interface in servicesInterfaceList ) {
        if ( [interface respondsToSelector:@selector(netWorkServices:startSendNetRequest:ProgressStat:additionInfo:)] ) {
            [interface netWorkServices:self startSendNetRequest:netRequest ProgressStat:stat additionInfo:additionInfo];
        }
    }
    
    return nil;
}

- (void) _startSendNetRequest:(NetRequest*) netRequest
{
    
}

- (void) _doneSendNetRequest:(NetRequest*) netRequest
{
    
}


- (void) addInterfaceLister:(id<NetWorkServicesInterface>) interface
{
    if ( nil == servicesInterfaceList ) {
        servicesInterfaceList = [[NSMutableArray alloc] init];
    }
    
    if ( interface != nil ) {
        [servicesInterfaceList addObject:interface];
    }
}

- (void) removeInterfaceLister:(id<NetWorkServicesInterface>) interface
{
    if ( interface != nil ) {
        [servicesInterfaceList removeObject:interface];
    }
}


@end
