//
//  SHSocketOperationQueue.m
//  MPRSP
//
//  Created by sherwin on 13-4-24.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import "SHSocketOperationQueue.h"
#import "SHSocketOperation.h"

//@interface <# class name #> (<# category name #>)
//
//@end

@implementation SHSocketOperationQueue
@synthesize dowloadOperationQueue = _dowloadOperationQueue;

- (id)init
{
    self = [super init];
    if (self) {
        _dowloadOperationQueue = [[NSMutableDictionary alloc] init];
        self.maxConcurrentOperationCount = 5;
    }

    return self;
}

- (void)dealloc {
    
    //1.中断所有的请求连接
    for (SHSocketOperation *socketOper in _dowloadOperationQueue) {
        [socketOper disconnect];
    }
    
    [_dowloadOperationQueue removeAllObjects];
    [_dowloadOperationQueue release];
    [super dealloc];
}

#pragma mark - Methord
-(BOOL) add:(SHSocketOperation*) socketOper
{
    if (_dowloadOperationQueue.allKeys.count > self.maxConcurrentOperationCount) {
        return NO;
    }
    
    NSString *operkey = [NSString stringWithFormat:@"%d",socketOper.sockTag];
    
    //1、查找是否有运行中该tag线程
    SHSocketOperation *srcOper = NULL;
    if( (srcOper = [_dowloadOperationQueue objectForKey:operkey]) !=NULL) //队列中存在该连接
    {
        if (!srcOper.isFinished) {
            return YES;
        }
    }
    
    //1.1 如果没有， 加入队列
    [_dowloadOperationQueue setObject:socketOper forKey:operkey];
    
    //2、启动该连接
    
    return YES;
}

-(BOOL) remove:(SHSocketOperation*) socketOper
{
    socketOper.delegate = nil;
    
    [socketOper disconnect];
    //数据暂存
    
    [_dowloadOperationQueue removeObjectForKey:[NSString stringWithFormat:@"%d",socketOper.sockTag]];
    return YES;
}

-(SHSocketOperation*) getSocketOperation:(int) tag
{
    return [_dowloadOperationQueue objectForKey:[NSString stringWithFormat:@"%d",tag]];
}
@end
