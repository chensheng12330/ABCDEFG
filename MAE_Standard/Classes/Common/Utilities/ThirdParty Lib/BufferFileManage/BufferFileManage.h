//
//  BufferFileManage.h
//  MPRSP
//
//  Created by sherwin on 13-4-17.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CP_All,   //清除全部
    CP_Time,  //清除小于某一时间[天数]
    CP_Size   //大小
}
BFCachePolicy;

@interface BufferFileManage : NSObject

+(NSString*) getCacheImageFolderPath;
+(BOOL)  isOverdueTimeWithCacheFilePath:(NSString*) imagePath OverdueTime:(double) hour;

+(BOOL) clearImageCacheWithPolicy:(BFCachePolicy) cachePolicy Value:(int)nValue;

@end
