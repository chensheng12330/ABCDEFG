//
//  ASIHttp.h
//  Template
//
//  Created by Knife on 13-1-3.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

// 用ASIHttp第三方库实现的Http协议解析类

#import <Foundation/Foundation.h>
#import "Interface.h"
#import "ASIFormDataRequest.h"

@interface ASIHttp : NSObject <HttpSynInterface>
{
    NSError *_error;                                    // 当前的错误对象
    NSURL *_url;                                        // 请求的网络地址
    NSString *_responseString;                          // 网络请求完成后的字符内容
    NSData *_responseData;                              // 网络请求完成后的二进制数据
    NSObject *_userInfo;                                // 用户自定义数据结构
    
    NSMutableDictionary *_postValueDictionary;          // 请求的post对象
    NSMutableDictionary *_headValueDictionary;          // 请求的post对象
    NSMutableDictionary *_getValueDictionary;          // 请求的post对象
    NSString *_requestMethod;
}

@property (nonatomic, retain) NSMutableDictionary *postValueDictionary;
@property (nonatomic, retain) NSMutableDictionary *headValueDictionary;
@property (nonatomic, retain) NSMutableDictionary *getValueDictionary;

@end
