//
//  NSString+marshmallows.m
//  Marshmallows
//
//  Created by Sami Samhuri on 11-09-03.
//  Copyright 2011 Sami Samhuri. All rights reserved.
//

#import "NSString+marshmallows.h"

// Encode a string to embed in an URL.
NSString* URLEncode(NSString *string) {
    return (NSString *)
    CFURLCreateStringByAddingPercentEscapes(NULL,
                                            (CFStringRef) string,
                                            NULL,
                                            (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                            kCFStringEncodingUTF8);
}


@implementation NSString (NSString_marshmallows)

- (NSString *) stringByTrimmingWhitespace
{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *) firstMatch: (NSString *)pattern
{
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern: pattern
                                  options: NSMatchingReportCompletion
                                  error: NULL];
    NSRange match = [regex rangeOfFirstMatchInString: self
                                             options: NSMatchingReportCompletion
                                               range: NSMakeRange(0, self.length)];
    return match.location == NSNotFound ? nil : [self substringWithRange: match];
}

- (NSString *) stringByReplacing: (NSString *)pattern with: (NSString *)replacement
{
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern: pattern
                                  options: NSRegularExpressionCaseInsensitive
                                  error: NULL];
    return [regex stringByReplacingMatchesInString: self
                                           options: NSMatchingReportCompletion
                                             range: NSMakeRange(0, [self length])
                                      withTemplate: @""];
}

- (NSString *) stringByReplacingFirst: (NSString *)pattern with: (NSString *)replacement
{
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern: pattern
                                  options: NSMatchingReportCompletion
                                  error: NULL];
    NSRange match = [regex rangeOfFirstMatchInString: self
                                             options: NSMatchingCompleted
                                               range: NSMakeRange(0, self.length)];
    if (match.location != NSNotFound) {
        NSString *rest = [self substringFromIndex: match.location + match.length];
        return [[[self substringToIndex: match.location]
                 stringByAppendingString: replacement]
                stringByAppendingString: rest];
    }
    return [[self copy] autorelease];
}

- (NSString *) stringByURLEncoding
{
    return URLEncode(self);
}

@end
