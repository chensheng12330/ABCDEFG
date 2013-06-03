//
//  HttpClientComponent.m
//  UniversalArchitecture
//
//  Created by issuser on 12-10-29.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import "HttpClientComponent.h"
#import "AppConstants.h"
//#import "Encryption.h"
//#import "GzipUtility.h"

@interface HttpClientComponent() {
    id callbackTarget;
    SEL failedSelector;
}

@property (assign) id callbackTarget;
@property (assign) SEL failedSelector;
@property (nonatomic, retain) NSTimer *timeoutTimer;

@end

@implementation HttpClientComponent

@synthesize didFinishSelector;
@synthesize didFailSelector;
@synthesize delegate;
@synthesize responseString, error;
@synthesize callbackTarget, failedSelector, timeoutTimer;

- (void)dealloc {
//    [timeoutTimer release];
    [responseString release];
    [error release];
    if (request != nil) {
        [request release];
        request = nil;
    }
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)sendPOSTRequestWithUrl:(NSString *)url
                 requestHeader:(NSDictionary *)headers
                   requestBody:(NSString *)body
                        target:(id)target
      requestDidFinishSelector:(SEL)finishSelector
         equestDidFailSelector:(SEL)failSelector {

    request = [[ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]] retain];
    [request setRequestMethod:@"POST"];

    //连接重用关闭
    [request setShouldAttemptPersistentConnection:NO];
    [request setNumberOfTimesToRetryOnTimeout:0];
    //设置超时时间
    [request setTimeOutSeconds:kRequsetTimeOutSeconds];
    
    if (headers) {
        [request setRequestHeaders:[NSMutableDictionary dictionaryWithDictionary:headers]];
    }
    
    if (body) {
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        //NSLog(@"bodyData原始长度:%d",[bodyData length]);
        
        //压缩
//        NSData *zipData = [GzipUtility compressData:bodyData];
        //NSLog(@"bodyData压缩长度:%d",[zipData length]);
        
        //Encrypt
//        NSData *encryptPostData = [zipData AESEncryptWithKey:AES_KEY];
        //NSLog(@"bodyData加密长度:%d",[encryptPostData length]);
        NSData *encryptPostData = bodyData;

        NSString *postLength = [NSString stringWithFormat:@"%d", [encryptPostData length]];
        [request addRequestHeader:@"Content-Length" value:postLength];
        [request setPostBody:[NSMutableData dataWithData:encryptPostData]];
    }
    
    [request setCompletionBlock:^{
        NSData *responseData = [request responseData];
        //NSLog(@"responseData原始长度:%d",[responseData length]);
        
//        responseData = [responseData AESDecryptWithKey:AES_KEY];
        //NSLog(@"responseData解密后长度:%d",[responseData length]);
        
//        responseData = [GzipUtility decompressData:responseData];
        //NSLog(@"responseData解压后长度:%d",[responseData length]);

        self.responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
        if (target) {
            [target performSelector:finishSelector withObject:self];
        }
        [self abort];
    }];
    [request setFailedBlock:^{
        self.error = [request error];
        if (target) {
            [target performSelector:failSelector withObject:self];
        }
        [self abort];

    }];
    
    [request startAsynchronous];
    
    //自定义时间超时
    self.timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:kRequsetTimeOutSeconds target:self selector:@selector(handleTimer) userInfo:nil repeats:NO];
    self.callbackTarget = target;
    self.failedSelector = failSelector;
    
}

- (void)abort {
    [timeoutTimer invalidate];
    [request cancel];
    if (request != nil) {
        [request release];
        request = nil;
    }
}

//时间超时定义
- (void)handleTimer
{
    [timeoutTimer invalidate];
    if (request != nil) {
        NSLog(@"timer to do");
        [self abort];
        self.error = [NSError errorWithDomain:@"时间超时！" code:256 userInfo:nil];
        if (callbackTarget) {
            [callbackTarget performSelector:failedSelector withObject:self];
        }
    }
    else {
        NSLog(@"timer nothing to do");
    }
}


@end

