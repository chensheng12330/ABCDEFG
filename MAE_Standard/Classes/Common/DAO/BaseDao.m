//
//  BaseDao.m
//  UniversalArchitecture
//
//  Created by issuser on 12-12-6.
//  Copyright (c) 2012年 issuser. All rights reserved.
//

#import "BaseDao.h"

@implementation BaseDao

- (id)queryWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db { return nil; }
- (BOOL)insertWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db { return NO; }
- (BOOL)updateWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db { return NO; }
- (BOOL)deleteWithEntity:(Entity *)entity inDatabase:(SQLiteDatabase *)db { return NO; }

@end
