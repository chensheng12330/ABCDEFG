//
//  BaseDao.h
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "SQLiteDatabase.h"

@interface BaseDao : NSObject
/**
 * 查询
 * @param entity
 * @return
 */
- (id)queryWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db;

/**
 * 新增
 * @param entity
 * @return
 */
- (BOOL)insertWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db;

/**
 * 修改
 * @param  <#property#>
 * @return <#property#>
 */

- (BOOL)updateWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db;

/**
 *
 * 删除
 * @param entity
 * @return
 */
- (BOOL)deleteWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db;



@end
