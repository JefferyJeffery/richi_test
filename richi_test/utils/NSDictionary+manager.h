//
//  NSDictionary+manager.h
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (manager)
-(nullable id)valueWithoutNSNullForKey:(nonnull NSString *)key;
@end
