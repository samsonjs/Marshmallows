//
//  MMHTTPClient.m
//  Marshmallows
//
//  Created by Sami Samhuri on 11-09-03.
//  Copyright 2011 Guru Logic. All rights reserved.
//

#import "MMHTTPClient.h"
#import "NSString+sanity.h"

MMHTTPClient *_client;

NSString *JoinURLComponents(NSString *first, va_list args)
{
    NSMutableString *url = [NSMutableString string];
    NSString *slash = @"";
    for (NSString *arg = first; arg != nil; arg = va_arg(args, NSString *)) {
        [url appendFormat: @"%@%@", slash, [arg stringByURLEncoding]];
        slash = @"/";
    }
    return [NSString stringWithString: url];
}

@implementation MMHTTPClient

@synthesize baseURL = _baseURL;
@synthesize timeout = _timeout;

+ (MMHTTPClient *) sharedClient
{
    if (!_client) {
        _client = [[self alloc] init];
    }
    return _client;
}

+ (id) client
{
    return [[[self alloc] init] autorelease];
}

+ (id) clientWithBaseURL: (NSString *)baseURL
{
    return [[[self alloc] initWithBaseURL: baseURL] autorelease];
}

+ (id) clientWithBaseURL: (NSString *)baseURL timeout: (NSUInteger)timeout
{
    return [[[self alloc] initWithBaseURL: baseURL timeout: timeout] autorelease];
}

+ (NSString *) pathFor: (NSString *)first, ...
{
    va_list args;
    va_start(args, first);
    NSString *url = JoinURLComponents(first, args);
    va_end(args);
    return url;
}

+ (NSString *) urlFor: (NSString *)first, ...
{
    va_list args;
    va_start(args, first);
    NSString *url = [[[self sharedClient] baseURL] stringByAppendingString: JoinURLComponents(first, args)];
    va_end(args);
    return url;
}

+ (NSString *) urlWithPath: (NSString *)path
{
    return [[[self sharedClient] baseURL] stringByAppendingPathComponent: path];
}

+ (void) request: (NSDictionary *)options then: (MMHTTPClientCallback)callback
{
    [[self sharedClient] request: options then: callback];
}

+ (void) get: (NSString *)url then: (MMHTTPClientCallback)callback
{
    [[self sharedClient] get: url then: callback];
}

+ (void) getImage: (NSString *)url then: (MMHTTPClientImageCallback)callback
{
    [[self sharedClient] getImage: url then: callback];
}

+ (void) getText: (NSString *)url then: (MMHTTPClientTextCallback)callback
{
    [[self sharedClient] getText: url then: callback];
}

+ (void) post: (NSString *)url then: (MMHTTPClientCallback)callback
{
    [[self sharedClient] post: url then: callback];
}

+ (void) post: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback
{
    [[self sharedClient] post: url data: data then: callback];
}

+ (void) put: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback
{
    [[self sharedClient] put: url data: data then: callback];
}

+ (void) delete: (NSString *)url then: (MMHTTPClientCallback)callback
{
    [[self sharedClient] delete: url then: callback];
}

- (id) init
{
    return [self initWithBaseURL: nil timeout: MMHTTPClientDefaultTimeout];
}

- (id) initWithBaseURL: (NSString *)baseURL
{
    return [self initWithBaseURL: baseURL timeout: MMHTTPClientDefaultTimeout];
}

- (id) initWithBaseURL: (NSString *)baseURL timeout: (NSUInteger)timeout
{
    self = [super init];
    if (self) {
        _baseURL = [baseURL copy];
        _timeout = timeout;
        _callbacks = [[NSMutableDictionary alloc] init];
        _connections = [[NSMutableDictionary alloc] init];
        _data = [[NSMutableDictionary alloc] init];
        _headers = [[NSMutableDictionary alloc] init];
        _statusCodes = [[NSMutableDictionary alloc] init];
        _types = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSString *) pathFor: (NSString *)first, ...
{
    va_list args;
    va_start(args, first);
    NSString *url = JoinURLComponents(first, args);
    va_end(args);
    return url;
}

- (NSString *) urlFor: (NSString *)first, ...
{
    va_list args;
    va_start(args, first);
    NSString *url = [_baseURL stringByAppendingString: JoinURLComponents(first, args)];
    va_end(args);
    return url;
}

- (NSString *) urlWithPath: (NSString *)path
{
    return [_baseURL stringByAppendingPathComponent: path];
}

- (void) getImage: (NSString *)url then: (MMHTTPClientImageCallback)callback
{
    [self request: [NSDictionary dictionary] then: (MMHTTPClientCallback)callback];
}

- (void) getText: (NSString *)url then: (MMHTTPClientTextCallback)callback
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             url,     @"url",
                             @"text", @"type",
                             nil];
    [self request: options then: (MMHTTPClientCallback)callback];
}

- (void) get: (NSString *)url then: (MMHTTPClientCallback)callback
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             url,      @"url",
                             @"image", @"type",
                             nil];
    [self request: options then: (MMHTTPClientCallback)callback];
}

- (void) post: (NSString *)url then: (MMHTTPClientCallback)callback
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"POST", @"method",
                             url,     @"url",
                             nil];
    [self request: options then: callback];
}

- (void) post: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"POST", @"method",
                             url,     @"url",
                             data,    @"data",
                             nil];
    [self request: options then: callback];
}

- (void) put: (NSString *)url data: (NSData *)data then: (MMHTTPClientCallback)callback
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"PUT",  @"method",
                             url,     @"url",
                             data,    @"data",
                             nil];
    [self request: options then: callback];
}

- (void) delete: (NSString *)url then: (MMHTTPClientCallback)callback
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"DELETE", @"method",
                             url,       @"url",
                             nil];
    [self request: options then: callback];
}

- (void) request: (NSDictionary *)options then: (MMHTTPClientCallback)callback
{
    NSString *urlString = [options valueForKey: @"url"];
    NSString *method = [options valueForKey: @"method"];
    NSData *data = [options valueForKey: @"data"];
    NSDictionary *headers = [options valueForKey: @"headers"];
    NSString *type = [options valueForKey: @"type"];
    
    if (!method) method = @"GET";
    
    if (![[urlString substringToIndex: 5] isEqualToString: @"http:"]
        && ![[urlString substringToIndex: 6] isEqualToString: @"https:"])
    {
        urlString = [self urlWithPath: urlString];
    }
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url
                                                           cachePolicy: NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval: self.timeout];
    [request setHTTPMethod: method];
    
    if (data && ([method isEqualToString: @"POST"] || [method isEqualToString: @"PUT"])) {
        [request setHTTPBody: data];
    }
    
    if (headers) {
        for (NSString *key in headers) {
            [request setValue: [headers objectForKey: key] forHTTPHeaderField: key];
        }
    }
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest: request delegate: self];
    NSString *key = [connection description];
    [_callbacks setObject: [[callback copy] autorelease] forKey: [connection description]];
    [_connections setObject: connection forKey: key];
    if (type) [_types setObject: type forKey: key];
}


#pragma mark - NSURLConnection delegate methods

- (void) connection: (NSURLConnection *)connection didReceiveResponse: (NSURLResponse *)response
{
    NSString *key = [connection description];
    NSNumber *status;
    NSDictionary *headers;
    
    if ([response respondsToSelector :@selector(statusCode)])
    {
        status = [NSNumber numberWithInt: [(NSHTTPURLResponse *)response statusCode]];
        headers = [(NSHTTPURLResponse *)response allHeaderFields];
    }
    else {
        NSLog(@"Not an HTTP response? connection: %@ response: %@", connection, response);
        status = [NSNumber numberWithInt: 500];
        headers = [NSDictionary dictionary];
    }
    
    [_statusCodes setObject: status forKey: key];
    [_headers setObject: headers forKey: key];
    [_data setObject: [[[NSMutableData alloc] init] autorelease] forKey: key];
}

- (void) connection: (NSURLConnection *)connection didReceiveData: (NSData *)data
{
    [[_data objectForKey: [connection description]] appendData: data];
}

- (void) connection: (NSURLConnection *)connection didFailWithError: (NSError *)error
{
    NSString *key = [connection description];
    MMHTTPClientCallback callback = [_callbacks objectForKey: key];
    
    callback(MMHTTPClientStatusError, nil);
    
    [_statusCodes removeObjectForKey: key];
    [_callbacks removeObjectForKey: key];
    [_data removeObjectForKey: key];
}

- (void) connectionDidFinishLoading: (NSURLConnection *)connection
{
    NSString *key = [connection description];
    MMHTTPClientCallback callback = [_callbacks objectForKey: key];
    int status = [[_statusCodes objectForKey: key] intValue];
    NSString *type = [_types objectForKey: key];
    id data = nil;
    if (status == 200) {
        if ([type isEqualToString: @"text"]) {
            NSData *rawData = [_data objectForKey: key];
            data = [[[NSString alloc] initWithBytes: rawData.bytes
                                             length: rawData.length
                                           encoding: NSUTF8StringEncoding] autorelease];
        }
        else if ([type isEqualToString: @"image"]) {
            data = [UIImage imageWithData: [_data objectForKey: key]];
        }
        else {
            data = [_data objectForKey: key];
        }
    }
    
    callback(status, data);
    
    [_callbacks removeObjectForKey: key];
    [_connections removeObjectForKey: key];
    [_data removeObjectForKey: key];
    [_headers removeObjectForKey: key];
    [_statusCodes removeObjectForKey: key];
    [_types removeObjectForKey: key];
}

- (void) dealloc
{
    for (NSURLConnection *conn in _connections) {
        [conn cancel];
    }

    [_baseURL release];
    [_callbacks release];
    [_connections release];
    [_data release];
    [_headers release];
    [_statusCodes release];
    [_types release];
    [super dealloc];
}

@end
