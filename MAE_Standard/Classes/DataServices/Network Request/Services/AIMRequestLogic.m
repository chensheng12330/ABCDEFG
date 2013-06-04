//
//  AIMRequestLogic.m
//  Evercare
//
//  Created by Knife on 13-5-30.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "AIMRequestLogic.h"

static AIMRequestLogic *s_AIMRequestLogic = nil;

@implementation AIMRequestLogic

+ (AIMRequestLogic*) defaultAIMRequestLogic
{
    @synchronized( self ) {
        if( nil == s_AIMRequestLogic ) {
            s_AIMRequestLogic = [[AIMRequestLogic alloc] init];
        }
    }
    
    return s_AIMRequestLogic;
}

+ (void) initAIMRequestLogic
{
    AIMRequestLogic *aimRequestLogic = [AIMRequestLogic defaultAIMRequestLogic];
    
    [NWS addInterfaceLister:aimRequestLogic];
}


//
- (void) netWorkServices:(NetWorkServices*) netWorkServices         // 当前处理NetRequest对象的NetWorkServices
     startSendNetRequest:(NetRequest*) netRequest                   // 正在出来的NetRequest对象
            ProgressStat:(XProgressStat) stat                       // 当前进度状态
            additionInfo:(NSObject*) additionInfo                   // 附加参数，不同进度状态下，参数值有所不同
{
    switch ( stat ) {
            
        // 每次请求网络数据，都需要添加appkey参数
        case eStart:
            [netRequest.parameterEntity setHeadValue:APPKEY forKey:@"Appkey"];
            break;
        default:
            break;
    }
}

@end
