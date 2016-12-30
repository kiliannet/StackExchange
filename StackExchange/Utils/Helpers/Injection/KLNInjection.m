//
//  KLNInjection.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 9/10/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNInjection.h"

static NSMutableDictionary *mappings;

@implementation KLNInjection

#pragma mark - Livecycle

+ (void)initialize {
    [super initialize];
    
    mappings = [NSMutableDictionary new];
}

#pragma mark - Class methods

+ (void)registerProtocol:(Protocol *)protocol asClassType:(Class)type {
    [mappings setObject:[type class] forKey:NSStringFromProtocol(protocol)];
}

+ (Class)resolveProtocol:(Protocol *)protocol {
    @autoreleasepool {
        // Get type of protocol
        id typeService = [mappings objectForKey:NSStringFromProtocol(protocol)];
        
        // Error if not found
        NSAssert(typeService, @"Service not found");
        
        // Return a new instance of class conform to protocol
        return typeService;
    }
}

@end
