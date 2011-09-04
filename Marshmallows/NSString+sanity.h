//
//  NSString+sanity.h
//  Marshmallows
//
//  Created by Sami Samhuri on 11-09-03.
//  Copyright 2011 Guru Logic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_sanity)

- (NSString *) firstMatch: (NSString *)pattern;
- (NSString *) stringByReplacing: (NSString *)pattern with: (NSString *)replacement;
- (NSString *) stringByReplacingFirst: (NSString *)pattern with: (NSString *)replacement;
- (NSString *) stringByTrimmingWhitespace;
- (NSString *) stringByURLEncoding;

@end
