//
//  NetworkChangedNotification.h
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import <Foundation/Foundation.h>

/**需将SystemConfiguration.framework 添加进工程。*/

@class Reachability;

@interface NetworkChangedNotification : NSObject {
    Reachability* hostReach;
}

+ (NetworkChangedNotification *)sharedNetworkChangedNotification;

/**
 * 开始监听网络变化
 */
- (void)start;

/**
 * 停止监听网络变化
 */
- (void)stop;

@end
