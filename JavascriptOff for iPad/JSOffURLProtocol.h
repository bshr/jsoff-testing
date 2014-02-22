//
//  JSOffURLProtocol.h
//  JavascriptOff for iPad
//
//  Created by Lukasz on 1/2/14.
//  Copyright (c) 2014 LionCubs Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSOffURLProtocol : NSURLProtocol

@end

@interface JSOffURLProtocol ()
@property (nonatomic, strong) NSURLConnection *connection;

@end
