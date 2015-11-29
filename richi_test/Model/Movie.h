//
//  Movie.h
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "RTCoreDataAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSManagedObject

#pragma mark find
+(nullable NSArray<Movie *> *)findAll;
+(nullable Movie *)findFirstByidentifier:(nonnull NSString *)identifier;
#pragma mark update
+(nullable Movie *)updateData:(nonnull NSDictionary *)data;
+(nullable Movie *)updateData:(nonnull NSDictionary *)data context:(nonnull NSManagedObjectContext *)context;
@end

NS_ASSUME_NONNULL_END

#import "Movie+CoreDataProperties.h"
