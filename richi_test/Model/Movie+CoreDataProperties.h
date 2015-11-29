//
//  Movie+CoreDataProperties.h
//  richi_test
//
//  Created by Jeffery on 2015/11/29.
//  Copyright © 2015年 jeffery. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface Movie (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *poster;
@property (nullable, nonatomic, retain) NSString *rating;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *year;

@end

NS_ASSUME_NONNULL_END
