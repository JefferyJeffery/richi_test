//
//  NSDictionary+manager.m
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import "NSDictionary+manager.h"

@implementation NSDictionary (manager)
-(nullable id)valueWithoutNSNullForKey:(NSString *)key
{
    NSString *identifier = [self valueForKey:key];
    
    if ([identifier isKindOfClass:[NSNull class]]) {
        identifier = nil;
    }
    
    return identifier;
}
@end
