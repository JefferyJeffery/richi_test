//
//  RTCoreDataAPI.h
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface RTCoreDataAPI : NSObject
+(nonnull RTCoreDataAPI *)shareManager;

#pragma mark - api
+(nonnull NSManagedObjectContext *)managedObjectContext;
+(void)saveContext:(nonnull NSManagedObjectContext *)context;

#pragma mark find
-(nullable NSArray *)findAllInEntity:(nonnull NSString *)entityValue;
-(nullable NSManagedObject *)findFirstInEntity:(nonnull NSString *)entityValue identifier:(nonnull NSString *)identifier;

#pragma mark update
-(nullable NSManagedObject *)updateInEntity:(nonnull NSString *)entityName data:(nonnull NSDictionary *)data;
-(nullable NSManagedObject *)updateInEntity:(nonnull NSString *)entityName data:(nonnull NSDictionary *)data context:(nonnull NSManagedObjectContext *)context;
@end
