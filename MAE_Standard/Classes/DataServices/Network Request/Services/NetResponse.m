//
//  NetResponse.m
//  Template
//
//  Created by Knife on 13-1-1.
//  Copyright (c) 2013年 Knife. All rights reserved.
//

#import "NetResponse.h"
#import "JSONKit.h"

@implementation NetResponse

@synthesize responseDictionary = _responseDictionary;
@synthesize netResponseFromType = _netResponseFromType;
@synthesize serializeJsonString = _serializeJsonString;

- (id) initWithJson:(NSString*) jsonString
{
    self = [super init];
    
    if ( nil != self ) {
        _serializeJsonString = [jsonString copy];
        
        _responseDictionary = [[jsonString objectFromJSONString] retain];
    }
    
    return self;
}

- (id) objectForKey:(NSString*) key
{
    return [_responseDictionary objectForKey:key];
}

- (void)dealloc
{
    [_responseDictionary release];
    [_serializeJsonString release];

    [super dealloc];
}

@end
