//
//  NetworkChangedNotification.m
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//


#import "NetworkChangedNotification.h"
#import "Reachability.h"

@implementation NetworkChangedNotification

static NetworkChangedNotification *sharedSingleton_ = nil;

- (void) start
{
    // do something
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
	hostReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
	[hostReach startNotifier];
}

- (void)stop {
    [hostReach release];
    // 删除通知对象
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//当网络状态发生变化的时候会调用.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"网络不可用");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"网络连接异常，请检查你的网络!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            break;
        }
            
        case ReachableViaWWAN:
        {
            NSLog(@"运营商网络");
            //do sth by zhangli
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"WiFi连接");
            //do sth by zhangli

            break;
        }
    }
}

+ (NetworkChangedNotification *)sharedNetworkChangedNotification
{
    if (sharedSingleton_ == nil)
    {
        sharedSingleton_ = [NSAllocateObject([self class], 0, NULL) init];
    }
    
    return sharedSingleton_;
}


+ (id) allocWithZone:(NSZone *)zone
{
    return [[self sharedNetworkChangedNotification] retain];
}


- (id) copyWithZone:(NSZone*)zone
{
    return self;
}

- (id) retain
{
    return self;
}

- (NSUInteger) retainCount
{
    return NSUIntegerMax; // denotes an object that cannot be released
}

- (oneway void) release
{
    // do nothing
}

- (id) autorelease
{
    return self;
}

@end
