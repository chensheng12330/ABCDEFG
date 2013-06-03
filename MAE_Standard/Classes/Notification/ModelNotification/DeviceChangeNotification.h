//
//  DeviceConnectNotification.h
//  MPRSP
//
//  Created by sherwin on 13-5-16.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

/*
 -(void) deviceChangeInfo:(NSNotification*) deviceInfo
 */

#import <UIKit/UIKit.h>

#define DEVICE_DEVUID  (@"DEVICE_DEVUID")
#define DEVICE_CONNECT (@"DEVICE_CONNECT")  //是否连接 [0:未连接  1:连接]
#define DEVICE_STONE   (@"DEVICE_STONE")    //存储大小 [float] KB
#define DEVICE_TYPE    (@"DEVICE_TYPE")     //设备类型 [0:MRP  1:UKEY]
#define DEVICE_BIND    (@"DEVICE_BIND")     //是否绑定

@interface DeviceChangeNotification : NSObject 

//监听者使用
+(BOOL) addDeviceNotificationObserver:(id)observer Selector:(SEL) selector;
+(void) removeDeviceNotificationObserver:(id)observer;

//推送者使用
+(void) postDeviceNotificationObject:(id)observer DeviceInfo:(NSDictionary*) userInfo;

@end


@interface DeviceChangeNotification  (Utilities)
//功能函数
+(BOOL) isConnect:(NSDictionary*) userInfo;
+(NSString*) deviceBadgeImageName:(NSDictionary*) userInfo;
@end