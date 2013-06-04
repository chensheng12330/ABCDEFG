//
//  AIMRequestLogic.h
//  Evercare
//
//  Created by Knife on 13-5-30.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkServices.h"

@interface AIMRequestLogic : NSObject <NetWorkServicesInterface>

+ (AIMRequestLogic*) defaultAIMRequestLogic;

+ (void) initAIMRequestLogic;

@end
