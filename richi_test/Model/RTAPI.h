//
//  RTAPI.h
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Movie;

@interface RTAPI : NSObject
+(nonnull RTAPI *)shareManager;
-(void)getTransformer:(void (^__nullable)(NSArray <Movie *> * __nullable movies, NSError * __nullable error))completionHandler;
@end
