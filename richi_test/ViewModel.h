//
//  ViewModel.h
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject
-(void)getMovies:(void (^__nullable)(NSError * __nullable error))completionHandler;
-(NSArray *)datalist;
@end
