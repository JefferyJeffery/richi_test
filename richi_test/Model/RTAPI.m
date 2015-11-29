//
//  RTAPI.m
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "RTAPI.h"
#import "Movie.h"

#define KBaseURL @"http://api.movies.io"

@implementation RTAPI
+(RTAPI *)shareManager
{
    static dispatch_once_t onceToken;
    static RTAPI *api;
    dispatch_once(&onceToken,^{
        api = [[RTAPI alloc] init];
    });
    return api;
}


-(void)getTransformer:(void (^__nullable)(NSArray <Movie *> * __nullable movies, NSError * __nullable error))completionHandler
{
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.movies.io";
    components.path = @"/movies/search";
    components.query = @"q=transformer";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:components.URL];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSError *error;
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            NSManagedObjectContext *context =  [RTCoreDataAPI managedObjectContext];
            
            for (NSDictionary *movie in dic[@"movies"]) {
                NSString *identified = [movie valueForKey:@"id"];
                if (identified) {
                    NSMutableDictionary *data =
                    [NSMutableDictionary dictionaryWithDictionary:
                     @{@"id":identified,
                       @"rating":[movie valueForKey:@"rating"]?:@"",
                       @"title":[movie valueForKey:@"title"]?:@"",
                       @"year":[movie valueForKey:@"year"]?:@"",
                       @"poster":[movie valueForKeyPath:@"poster.urls.original"]?:@"",
                       }];
                    [Movie updateData:data context:context];
                }
            }
            [RTCoreDataAPI saveContext:context];
            
            if (completionHandler) {
                completionHandler([Movie findAll],nil);
            }
        } else {
            if (completionHandler) {
                completionHandler(nil,error);
            }
        }
    }];
    [task resume];
}


@end
