//
//  NetWork.m
//  Template
//
//  Created by 陈双龙 on 13-1-29.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "NetWork.h"

NetWork *static_netWork;

@implementation NetWork

@synthesize status = _status;

+ (NetWork*) defaultNetWork
{
    @synchronized( self ) {
        if( nil == static_netWork ) {
            static_netWork = [[NetWork alloc] init];
            [static_netWork startNotificationNetwork];
        }
    }
    
    return static_netWork;
}

- (id) init
{
    self = [super init];
    
    if ( self != nil ) {
        isListe = NO;
    }
    
    return self;
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach
{
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if ( status == NotReachable ) {
        NSLog(@"NotReachable connect");
    } else if ( status == ReachableViaWiFi ) {
        NSLog(@"ReachableViaWiFi connect with the internet successfully");
    } else if ( status == ReachableViaWWAN ){
        NSLog(@"ReachableViaWWAN connect with the internet successfully");
    }
    
    _status = status;
}


// 连接改变
- (void) reachabilityChanged: (NSNotification* )note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability: curReach];
}


-(void)startNotificationNetwork {
    
    if ( isListe ) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    reachability=[[Reachability reachabilityWithHostName:@"www.baidu.com"] retain];
    [reachability startNotifier];
    
    isListe = YES;
}


@end
