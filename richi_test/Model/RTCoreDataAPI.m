//
//  RTCoreDataAPI.m
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "RTCoreDataAPI.h"
#import "NSDictionary+manager.h"

@implementation RTCoreDataAPI
+(RTCoreDataAPI *)shareManager
{
    static dispatch_once_t oneToken;
    static RTCoreDataAPI *api;
    
    dispatch_once(&oneToken, ^{
        api = [[RTCoreDataAPI alloc] init];
    });
    
    return api;
}

#pragma mark - dic

#define kMovie_PK @"id"
-(NSDictionary *)movieMapping
{
    return @{
             kMovie_PK:@"id",
             @"poster":@"poster",
             @"rating":@"rating",
             @"title":@"title",
             @"year":@"year",
             };
}


#pragma mark - api
+(NSManagedObjectContext *)managedObjectContext
{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}

+(void)saveContext:(NSManagedObjectContext *)context
{
    NSManagedObjectContext *managedObjectContext = context;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(nullable NSArray *)findAllInEntity:(NSString *)entityValue
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityValue];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"year" ascending:NO]];
    request.resultType = NSManagedObjectResultType;
    
    NSError *error;
    
    NSArray *array = [[RTCoreDataAPI managedObjectContext] executeFetchRequest:request error:&error];
    return array;
}

-(nullable NSManagedObject *)findFirstInEntity:(NSString *)entityValue identifier:(NSString *)identifier
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityValue];
    request.predicate = [NSPredicate predicateWithFormat:@"%K == %@",kMovie_PK,identifier];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"year" ascending:YES]];
    request.resultType = NSManagedObjectResultType;
    
    NSError *error;
    
    NSArray *array = [[RTCoreDataAPI managedObjectContext] executeFetchRequest:request error:&error];
    if (!error) {
        if (array.count > 0) {
            return array.firstObject;
        }
    }
    
    return nil;
}

-(nullable NSManagedObject *)updateInEntity:(NSString *)entityName data:(NSDictionary *)data
{
    NSManagedObjectContext *context = [RTCoreDataAPI managedObjectContext];
    
    NSManagedObject *managedObject = [self updateInEntity:entityName data:data context:context];
    
    [RTCoreDataAPI saveContext:context];
    
    return managedObject;
}


-(nullable NSManagedObject *)updateInEntity:(NSString *)entityName data:(NSDictionary *)data context:(NSManagedObjectContext *)context
{
    NSManagedObject *managedObject = nil;
    NSString *identifier = [data valueWithoutNSNullForKey:kMovie_PK];
    
    if (identifier) {
        managedObject = [self findFirstInEntity:entityName identifier:identifier];
        
        if (!managedObject) {
            managedObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
            [managedObject setValue:identifier forKey:kMovie_PK];
        }
        
        for (NSString *key in self.movieMapping.allKeys) {
            if (![key isEqualToString:kMovie_PK]) {
                __strong id value = [data valueWithoutNSNullForKey:key];
                if (value) {
                    if ([value isKindOfClass:[NSNumber class]]) {
                        NSString *string = [NSNumberFormatter localizedStringFromNumber:value numberStyle:NSNumberFormatterNoStyle];
                        [managedObject setValue:string forKey:key];
                    } else if ([value isKindOfClass:[NSString class]]) {
                        [managedObject setValue:value forKey:key];
                    } else {
                        NSString *string = [NSString stringWithFormat:@"%@",value];
                        [managedObject setValue:string forKey:key];
                    }
                }
            }
        }
    }
    
    return managedObject;
}
@end
