//
//  NetWork.h
//  Template
//
//  Created by 陈双龙 on 13-1-29.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetWork : NSObject
{
    Reachability *reachability;
    NetworkStatus _status;
    BOOL isListe;
}

@property (nonatomic, assign) NetworkStatus status;

+ (NetWork*) defaultNetWork;

@end
