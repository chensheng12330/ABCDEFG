//
//  Entity.m
//  AmwayMCommerce
//
//  Created by 张 黎 on 12-12-28.
//
//

#import "Entity.h"

@implementation Entity

@synthesize primaryKeyID;


- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        primaryKeyID = 0;
    }
    return self;
}


@end
