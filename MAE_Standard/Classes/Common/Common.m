//
//  Common.m
//  MPRSP
//
//  Created by sherwin on 13-4-19.
//  Copyright (c) 2013年 SoftStone. All rights reserved.
//

#import "Common.h"

static Common *_sharedCommon = nil;

@implementation Common


#pragma mark - object init
+(Common*) sharedCommon
{
    @synchronized(self)
    {
        if (nil == _sharedCommon ) {
            _sharedCommon = [[self alloc] init];
        }
    }
    return _sharedCommon;
}

+(id)alloc
{
    @synchronized([Common class]) //线程访问加锁
    {
        NSAssert(_sharedCommon == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedCommon  = [super alloc];
        return _sharedCommon;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        //database init
        //[self initDatabase];
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _sharedCommon) {
            _sharedCommon = [super allocWithZone:zone];
            return _sharedCommon;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc
{
    [super dealloc];
    _sharedCommon = nil;
}

- (oneway void)release
{
    // do nothing
    if( _sharedCommon == nil)
    {
        NSLog(@"SHDBManage: retainCount is 0.");
        return;
    }
    [super release];
    return;
}

- (id)retain
{
    return self;
}

//- (id)autorelease
//{
//    return self;
//}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

#pragma mark - Method
@end
