//
//  SHDBManage.m
//  iNote
//
//  Created by Sherwin.Chen on 12-12-7.
//
//

#import "SHDBManage.h"

//expand NSString head


#ifndef DBMQuickCheck//(SomeBool)
#define DBMQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }
#endif

#ifndef DBMRollback//(SomeBool)
#define DBMRollback(SomeBool) { if (!(SomeBool)) { [db rollback]; return NO;} }
#endif

//log out flag
#ifndef DEBUG_OUT
#define DEBUG_OUT 1
#endif

//0 FALSE
//1 nil
#ifndef DEBUG_DB_ERROR_LOG
#define DEBUG_DB_ERROR_LOG { if(DEBUG_OUT) { if([db hadError]){ NSLog(@"DB ERROR: %@ on line %d",[db lastErrorMessage],__LINE__);return FALSE;}}}
#endif


static SHDBManage *_sharedDBManage = nil;

@interface SHDBManage (private)

@end


@implementation SHDBManage
@synthesize dbErrorInfo = _dbErrorInfo;

#pragma mark - object init
+(SHDBManage*) sharedDBManage
{
    @synchronized(self)
    {
        if (nil == _sharedDBManage ) {
            _sharedDBManage = [[self alloc] init];
        }
    }
    return _sharedDBManage;
}

+(id)alloc
{
    @synchronized([SHDBManage class]) //线程访问加锁
    {
        NSAssert(_sharedDBManage == nil, @"Shewin: Attempted to allocate a second instance of a singleton.Please call +[sharedExerciseManage] method.");
        _sharedDBManage  = [super alloc];
        return _sharedDBManage;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        //database init
        db = [[FMDatabase alloc] initWithDBName:@"inote.db"];
        DBMQuickCheck([db open]);
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (nil == _sharedDBManage) {
            _sharedDBManage = [super allocWithZone:zone];
            return _sharedDBManage;
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
    [_dbErrorInfo release];
    /*
     other property release
     */
    if (db==nil) { return;}
    else         {[db close]; [db release]; db =nil;}
    
    [super dealloc];
    _sharedDBManage = nil;
}

- (oneway void)release
{
    // do nothing
    if(db==nil)
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

- (id)autorelease
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; // This is sooo not zero
}

#pragma mark - SHDBManage_Private_fuction
@end
