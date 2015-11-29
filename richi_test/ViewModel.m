//
//  ViewModel.m
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "ViewModel.h"

#import "RTAPI.h"

@implementation ViewModel
{
    NSMutableArray *datalist;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        datalist = [NSMutableArray array];
    }
    return self;
}

-(void)getMovies:(void (^__nullable)(NSError * __nullable error))completionHandler
{
    [[RTAPI shareManager] getTransformer:^(NSArray<Movie *> * _Nullable movies, NSError * _Nullable error) {
        
        if (!error) {
            [datalist removeAllObjects];
            [datalist addObjectsFromArray:movies];
            
            if (completionHandler) {
                completionHandler(nil);
            }
        } else {
            if (completionHandler) {
                completionHandler(error);
            }
        }
    }];
}

-(NSArray *)datalist
{
    return datalist;
}

@end
