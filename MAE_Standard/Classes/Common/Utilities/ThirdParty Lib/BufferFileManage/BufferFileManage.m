//
//  BufferFileManage.m
//  MPRSP
//
//  Created by sherwin on 13-4-17.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "BufferFileManage.h"

#define BF_IMAGE_FOLDER (@"Cache_Image")
#define BF_FILE_FOLDER  (@"Buffer_File")

@implementation BufferFileManage

+(NSString*) getCacheImageFolderPath
{
    NSString *imageCachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pathComp = [imageCachePath stringByAppendingPathComponent:BF_IMAGE_FOLDER];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager isExecutableFileAtPath:pathComp])
    {
        [fileManager createDirectoryAtPath:pathComp withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return pathComp;
}

+(BOOL)  isOverdueTimeWithCacheFilePath:(NSString*) imagePath OverdueTime:(double) hour
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary* attributes   = [fileManager attributesOfItemAtPath:imagePath error:nil];
    if (attributes!=nil) {
        //NSFileModificationDate
        NSDate *fileData = [attributes objectForKey:@"NSFileModificationDate"];
        NSDate *nowData  = [NSDate date];
        
        double sec = [nowData timeIntervalSinceDate:fileData];
        if (sec > (hour*60*60)) {
            [fileManager removeItemAtPath:imagePath error:nil];
            return YES;
        }
    }
    return NO;
}

+(BOOL) clearImageCacheWithPolicy:(BFCachePolicy) cachePolicy Value:(int)nValue
{
    NSString *imageFolder = [BufferFileManage getCacheImageFolderPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* files = [fileManager contentsOfDirectoryAtPath:imageFolder error:nil];
    
    for(NSString *filePath in files)
    {
        NSString *fullPath = [imageFolder stringByAppendingPathComponent:filePath];
        
        [BufferFileManage isOverdueTimeWithCacheFilePath:fullPath OverdueTime:0.002];
        //[fileManager removeItemAtPath:fullPath error:nil];
    }
    
    return YES;
}
@end
