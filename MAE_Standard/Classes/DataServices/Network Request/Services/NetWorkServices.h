//
//  NetWorkServices.h
//  Template
//
//  Created by Knife on 13-1-1.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

// 网络数据服务的包装类

#import <Foundation/Foundation.h>
#import "NetRequest.h"

@class NetWorkServices;

// 进度的状态
typedef enum {
    eStart,                 // 开始准备发起http请求，还未设置参数
    eDoneParameter,         // 参数设置完成
    eDoneRequest,           // http请求完成
    eRequestComplete        // 当前NetRequest请求事件完成
}XProgressStat;

// NetWorkServices处理NetRequest进度接口
@protocol NetWorkServicesInterface <NSObject>

- (void) netWorkServices:(NetWorkServices*) netWorkServices         // 当前处理NetRequest对象的NetWorkServices
     startSendNetRequest:(NetRequest*) netRequest                   // 正在出来的NetRequest对象
            ProgressStat:(XProgressStat) stat                       // 当前进度状态
            additionInfo:(NSObject*) additionInfo;                  // 附加参数，不同进度状态下，参数值有所不同

@end

// 网络数据控制类
@interface NetWorkServices : NSObject
{
    NSMutableDictionary *_threadEnvInfo;        // 线程间的通信的公用数据结构
    NSMutableArray *servicesInterfaceList;
}

+ (NetWorkServices*) defaultNetWorkServices;

// 发送一个异步网络请求
// 请求对象
// 发送成功返回YES，否则NO
- (BOOL) sendRequest:(NetRequest*) netRequest                   // 请求对象
            UserInfo:(NSObject*) userInfo;                      // 自定义数据结构，请求完成后将返回给用户

- (void) addInterfaceLister:(id<NetWorkServicesInterface>) interface;
- (void) removeInterfaceLister:(id<NetWorkServicesInterface>) interface;

@end

#ifndef NWS
#define NWS [NetWorkServices defaultNetWorkServices]
#endif