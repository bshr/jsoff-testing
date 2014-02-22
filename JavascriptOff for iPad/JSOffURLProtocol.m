//
//  JSOffURLProtocol.m
//  JavascriptOff for iPad
//
//  Created by Lukasz on 1/2/14.
//  Copyright (c) 2014 LionCubs Project. All rights reserved.
//
//  based on http://eng.42go.com/customizing-uiwebview-requests-with-nsurlprotocol/
//

#import "JSOffURLProtocol.h"

@implementation JSOffURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    if ([NSURLProtocol propertyForKey:@"JSOff" inRequest:request] == nil) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

- (void)startLoading
{
    NSMutableURLRequest *mRequest = [self.request mutableCopy];
    [NSURLProtocol setProperty:@YES forKey:@"JSOff" inRequest:mRequest];
    self.connection = [NSURLConnection connectionWithRequest:mRequest delegate:self];
}

- (void)stopLoading
{
    [self.connection cancel];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    NSMutableDictionary *mHeaders = [NSMutableDictionary dictionary];
    NSString *CSP = @"default-src 'none'; img-src *;style-src 'unsafe-inline' *;child-src *;frame-src *;sandbox allow-forms allow-top-navigation";
    for(id h in response.allHeaderFields) {
        if(![[h lowercaseString] isEqualToString:@"content-security-policy"] && ![[h lowercaseString] isEqualToString:@"x-webkit-csp"]) {
            [mHeaders setObject:response.allHeaderFields[h] forKey:h];
        }
    }
    [mHeaders setObject:CSP forKey:@"Content-Security-Policy"];
    [mHeaders setObject:CSP forKey:@"X-Webkit-CSP"];
    NSHTTPURLResponse *mResponse = [[NSHTTPURLResponse alloc] initWithURL:response.URL statusCode:response.statusCode HTTPVersion:@"HTTP/1.1" headerFields:mHeaders];
    [self.client URLProtocol:self didReceiveResponse:mResponse cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
    self.connection = nil;
}

@end
