//
//  MMHTTPClient.h
//  Marshmallows
//
//  Created by Sami Samhuri on 11-09-03.
//  Copyright 2011 Guru Logic. All rights reserved.
//

#import <UIKit/UIImage.h>

#define MMHTTPClientStatusError -1
#define MMHTTPClientDefaultTimeout 120

typedef void (^MMHTTPClientCallback)(NSInteger status, id data);
typedef void (^MMHTTPClientTextCallback)(NSInteger status, NSString *text);
typedef void (^MMHTTPClientImageCallback)(NSInteger status, UIImage *image);

@interface MMHTTPClient : NSObject
{
    NSMutableDictionary *_callbacks;
    NSMutableDictionary *_connections;
    NSMutableDictionary *_data;
    NSMutableDictionary *_headers;
    NSMutableDictionary *_statusCodes;
    NSMutableDictionary *_types;
    NSString *_baseURL;
    NSUInteger _timeout;
}

+ (MMHTTPClient *) sharedClient;
+ (id) client;
+ (id) clientWithBaseURL: (NSString *)baseURL;
+ (id) clientWithBaseURL: (NSString *)baseURL timeout: (NSUInteger)timeout;

+ (NSString *) pathFor: (NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;
+ (NSString *) urlFor: (NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;
+ (NSString *) urlWithPath: (NSString *)path;
+ (void) request: (NSDictionary *)options then: (MMHTTPClientCallback)callback;
+ (void) get: (NSString *)url then: (MMHTTPClientCallback)callback;
+ (void) getImage: (NSString *)url then: (MMHTTPClientImageCallback)callback;
+ (void) getText: (NSString *)url then: (MMHTTPClientTextCallback)callback;
+ (void) post: (NSString *)url then: (MMHTTPClientCallback)callback;
+ (void) post: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback;
+ (void) put: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback;
+ (void) delete: (NSString *)url then: (MMHTTPClientCallback)callback;

@property (nonatomic, retain) NSString *baseURL;
@property NSUInteger timeout;

- (id) initWithBaseURL: (NSString *)baseURl;
- (id) initWithBaseURL: (NSString *)baseURl timeout: (NSUInteger)timeout;
- (NSString *) pathFor: (NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *) urlFor: (NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;
- (NSString *) urlWithPath: (NSString *)path;
- (void) request: (NSDictionary *)options then: (MMHTTPClientCallback)callback;
- (void) get: (NSString *)url then: (MMHTTPClientCallback)callback;
- (void) getImage: (NSString *)url then: (MMHTTPClientImageCallback)callback;
- (void) getText: (NSString *)url then: (MMHTTPClientTextCallback)callback;
- (void) post: (NSString *)url then: (MMHTTPClientCallback)callback;
- (void) post: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback;
- (void) put: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback;
- (void) delete: (NSString *)url then: (MMHTTPClientCallback)callback;

@end
