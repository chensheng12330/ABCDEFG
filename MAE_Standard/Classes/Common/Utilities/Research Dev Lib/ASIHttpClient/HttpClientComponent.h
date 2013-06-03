//
//  HttpClientComponent.h
//  UniversalArchitecture
//
//  Created by issuser on 12-10-29.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@protocol HttpClientComponentDelegate <NSObject>

@optional
- (void)requestFinishedWithResponse:(NSString *)responseString;
- (void)requestFailedWithError:(NSError *)NSError;

@end

@interface HttpClientComponent : NSObject<HttpClientComponentDelegate> {
    ASIHTTPRequest *request;
    
    SEL didFinishSelector;
	
	SEL didFailSelector;
    
    id<HttpClientComponentDelegate> delegate;
}

@property (assign) SEL didFinishSelector;
@property (assign) SEL didFailSelector;

@property (nonatomic, assign) id<HttpClientComponentDelegate> delegate;
@property (nonatomic, retain) NSString *responseString;
@property (nonatomic, retain) NSError *error;

/**
 * 发送post请求
 *
 * @param url
 *            请求的网络地址
 * @param headers
 *            请求头
 * @param body
 *            请求消息体
 * @param target
 *            注册目标
 * @param finishSelector
 *            请求完成回调
 * @param failSelector
 *            请求失败回调
 */

- (void)sendPOSTRequestWithUrl:(NSString *)url
                 requestHeader:(NSDictionary *)headers
                   requestBody:(NSString *)body
                        target:(id)target
      requestDidFinishSelector:(SEL)finishSelector
         equestDidFailSelector:(SEL)failSelector;

/**
 * 中止请求，回收资源
 */
- (void)abort;



@end
