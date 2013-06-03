//
//  SHSocketOperationQueue.h
//  MPRSP
//
//  Created by sherwin on 13-4-24.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

//NSOperationQueue

#import <Foundation/Foundation.h>

@class SHSocketOperation;

@interface SHSocketOperationQueue : NSObject

@property (nonatomic, retain) NSMutableDictionary *dowloadOperationQueue;
@property (nonatomic, assign) NSInteger maxConcurrentOperationCount;     //最大运行线程数

-(BOOL) add:(SHSocketOperation*) socketOper;
-(BOOL) remove:(SHSocketOperation*) socketOper;

-(SHSocketOperation*) getSocketOperation:(int) tag;

@end
