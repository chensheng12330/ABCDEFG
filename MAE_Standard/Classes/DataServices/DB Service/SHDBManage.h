//
//  SHDBManage.h
//  iNote
//
//  Created by Sherwin.Chen on 12-12-7.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface SHDBManage : NSObject
{
@private
    FMDatabase *db;
}

@property(readonly) NSString *dbErrorInfo;
//***************************************
//object init Method

/*
 初使化对象唯一方法
 */
+(SHDBManage*) sharedDBManage;


@end
