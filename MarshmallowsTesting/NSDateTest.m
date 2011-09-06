//
//  NSDateTest.m
//  Marshmallows
//
//  Created by Sami Samhuri on 11-09-04.
//  Copyright 2011 Guru Logic. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "NSDate+relative.h"

#define MINUTE 60.0
#define HOUR   (60.0 * MINUTE)
#define DAY    (24.0 * HOUR)
#define WEEK   (7.0 * DAY)
#define MONTH  (30.0 * DAY)
#define YEAR   (365.25 * DAY)

@interface NSDateTest : GHTestCase { }
@end

@implementation NSDateTest

- (void) testMethodExists
{
    NSDate *date = [NSDate date];
    GHAssertTrue([date respondsToSelector: @selector(relativeToNow)], @"Extension method -[NSDate relativeToNow] not available");
}

- (void) testPastDates
{
    NSDate *date;

    // < 1 minute ago
    date = [NSDate dateWithTimeIntervalSinceNow: -59.0];
    GHAssertEqualStrings(@"right now", [date relativeToNow], @"Incorrect relative date.");

    // < 2 minutes ago
    date = [NSDate dateWithTimeIntervalSinceNow: -119.0];
    GHAssertEqualStrings(@"a minute ago", [date relativeToNow], @"Incorrect relative date.");
    
    // < 1 hour ago
    date = [NSDate dateWithTimeIntervalSinceNow: -57 * MINUTE];
    GHAssertEqualStrings(@"57 minutes ago", [date relativeToNow], @"Incorrect relative date.");
    
    // < 2 hours ago
    date = [NSDate dateWithTimeIntervalSinceNow: -117 * MINUTE];
    GHAssertEqualStrings(@"an hour ago", [date relativeToNow], @"Incorrect relative date.");
    
    // < 1 day ago
    date = [NSDate dateWithTimeIntervalSinceNow: -23 * HOUR];
    GHAssertEqualStrings(@"23 hours ago", [date relativeToNow], @"Incorrect relative date.");
    
    // < 2 days ago
    date = [NSDate dateWithTimeIntervalSinceNow: -47 * HOUR];
    GHAssertEqualStrings(@"yesterday", [date relativeToNow], @"Incorrect relative date.");
    
    // < 1 week ago
    date = [NSDate dateWithTimeIntervalSinceNow: -6 * DAY];
    GHAssertEqualStrings(@"6 days ago", [date relativeToNow], @"Incorrect relative date.");
    
    // < 2 weeks ago
    date = [NSDate dateWithTimeIntervalSinceNow: -13 * DAY];
    GHAssertEqualStrings(@"last week", [date relativeToNow], @"Incorrect relative date.");
    
    // < 4 weeks ago
    date = [NSDate dateWithTimeIntervalSinceNow: -3 * WEEK];
    GHAssertEqualStrings(@"3 weeks ago", [date relativeToNow], @"Incorrect relative date.");
    
    // < 8 weeks ago
    date = [NSDate dateWithTimeIntervalSinceNow: -7 * WEEK];
    GHAssertEqualStrings(@"last month", [date relativeToNow], @"Incorrect relative date.");
    
    // < 1 year ago
    date = [NSDate dateWithTimeIntervalSinceNow: -11 * MONTH];
    GHAssertEqualStrings(@"11 months ago", [date relativeToNow], @"Incorrect relative date.");
    
    // last year
    date = [NSDate dateWithTimeIntervalSinceNow: -729 * DAY];
    GHAssertEqualStrings(@"last year", [date relativeToNow], @"Incorrect relative date.");
    
    // 5 years ago
    date = [NSDate dateWithTimeIntervalSinceNow: -5 * YEAR - 1];
    GHAssertEqualStrings(@"5 years ago", [date relativeToNow], @"Incorrect relative date.");
}

- (void) testFutureDates
{
    NSDate *date;
    
    // within 1 minute
    date = [NSDate dateWithTimeIntervalSinceNow: 59.0];
    GHAssertEqualStrings(@"right now", [date relativeToNow], @"Incorrect relative date.");
    
    // within 2 minutes
    date = [NSDate dateWithTimeIntervalSinceNow: 119.0];
    GHAssertEqualStrings(@"in a minute", [date relativeToNow], @"Incorrect relative date.");
    
    // within 1 hour
    date = [NSDate dateWithTimeIntervalSinceNow: 57 * MINUTE + 1];
    GHAssertEqualStrings(@"in 57 minutes", [date relativeToNow], @"Incorrect relative date.");
    
    // in an hour
    date = [NSDate dateWithTimeIntervalSinceNow: 117 * MINUTE];
    GHAssertEqualStrings(@"in an hour", [date relativeToNow], @"Incorrect relative date.");
    
    // within 1 day
    date = [NSDate dateWithTimeIntervalSinceNow: 23 * HOUR + 1];
    GHAssertEqualStrings(@"in 23 hours", [date relativeToNow], @"Incorrect relative date.");
    
    // tomorrow
    date = [NSDate dateWithTimeIntervalSinceNow: 47 * HOUR];
    GHAssertEqualStrings(@"tomorrow", [date relativeToNow], @"Incorrect relative date.");
    
    // within 1 week
    date = [NSDate dateWithTimeIntervalSinceNow: 6 * DAY + 1];
    GHAssertEqualStrings(@"in 6 days", [date relativeToNow], @"Incorrect relative date.");
    
    // next week
    date = [NSDate dateWithTimeIntervalSinceNow: 13 * DAY];
    GHAssertEqualStrings(@"next week", [date relativeToNow], @"Incorrect relative date.");
    
    // within 4 weeks
    date = [NSDate dateWithTimeIntervalSinceNow: 3 * WEEK + 1];
    GHAssertEqualStrings(@"in 3 weeks", [date relativeToNow], @"Incorrect relative date.");
    
    // next month
    date = [NSDate dateWithTimeIntervalSinceNow: 7 * WEEK];
    GHAssertEqualStrings(@"next month", [date relativeToNow], @"Incorrect relative date.");
    
    // within 1 year
    date = [NSDate dateWithTimeIntervalSinceNow: 11 * MONTH + 1];
    GHAssertEqualStrings(@"in 11 months", [date relativeToNow], @"Incorrect relative date.");
    
    // next year
    date = [NSDate dateWithTimeIntervalSinceNow: 729 * DAY];
    GHAssertEqualStrings(@"next year", [date relativeToNow], @"Incorrect relative date.");

    // in year 5 years
    date = [NSDate dateWithTimeIntervalSinceNow: 5 * YEAR + 1];
    GHAssertEqualStrings(@"in 5 years", [date relativeToNow], @"Incorrect relative date.");
}

@end
