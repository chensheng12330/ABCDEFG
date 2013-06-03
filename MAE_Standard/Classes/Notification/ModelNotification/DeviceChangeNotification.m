//
//  DeviceConnectNotification.m
//  MPRSP
//
//  Created by sherwin on 13-5-16.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import "DeviceChangeNotification.h"

#define MRPDeviceChangeNotification (@"DeviceChangeNotification")

@implementation DeviceChangeNotification

+(BOOL) addDeviceNotificationObserver:(id)observer Selector:(SEL) selector
{
    if([observer respondsToSelector:selector])
    {
        [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:MRPDeviceChangeNotification object:nil];
    }
    else
    {
        return NO;
    }
    
    return YES;
}

+(void) removeDeviceNotificationObserver:(id)observer
{
    if (observer==NULL) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:MRPDeviceChangeNotification object:nil];
}


//推送者使用
+(void) postDeviceNotificationObject:(id)observer DeviceInfo:(NSDictionary*) userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:MRPDeviceChangeNotification object:observer userInfo:userInfo];
}

#pragma mark -Uit
+(BOOL) isConnect:(NSDictionary*) userInfo
{
    NSString *value = [userInfo objectForKey:DEVICE_CONNECT];
    
    if(value == NULL || [value isEqualToString:@""]) return NO;
    
    return [value boolValue];
}

+(NSString*) deviceBadgeImageName:(NSDictionary*) userInfo
{
    NSString *value = [userInfo objectForKey:DEVICE_TYPE];
    
    if ([value boolValue]) {
        return @"_0009_icon_MPRUkey.png";
    }
    
    return @"_0008_icon_MPR1022B.png";
}

@end
