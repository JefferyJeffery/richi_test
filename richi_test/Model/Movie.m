//
//  Movie.m
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "Movie.h"

@implementation Movie
#pragma mark find
+(nullable NSArray<Movie *> *)findAll
{
    return [[RTCoreDataAPI shareManager] findAllInEntity:@"Movie"];
}

+(nullable Movie *)findFirstByidentifier:(NSString *)identifier
{
    return (Movie *)[[RTCoreDataAPI shareManager] findFirstInEntity:@"Movie"identifier:identifier];
}

#pragma mark update
+(nullable Movie *)updateData:(NSDictionary *)data
{
    return (Movie *)[[RTCoreDataAPI shareManager] updateInEntity:@"Movie" data:data context:[RTCoreDataAPI managedObjectContext]];
}

+(nullable Movie *)updateData:(NSDictionary *)data context:(NSManagedObjectContext *)context
{
    return (Movie *)[[RTCoreDataAPI shareManager] updateInEntity:@"Movie" data:data context:context];
}
@end
