//
//  NSDate+marshmallows.h
//  UberClassifieds
//
//  Created by Sami Samhuri on 11-06-18.
//  Copyright 2011 Betastreet Media. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (NSDate_marshmallows)

+ (NSDate *) dateWithYear: (NSInteger)year month: (NSInteger)month day: (NSInteger)day;
- (NSString *) relativeToNow;

@end
