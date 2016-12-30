//
//  KLNInjection.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 9/10/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLNInjection : NSObject

/**
 *  Register a protocol as concreted class type.
 *
 *  @param protocol conform to protocol.
 *  @param type     concreted class type.
 */
+ (void)registerProtocol:(Protocol *)protocol asClassType:(Class)type;

/**
 *  Return class type conform to protocol.
 *
 *  @param protocol conform to protocol.
 *
 *  @return class type.
 */
+ (Class)resolveProtocol:(Protocol *)protocol;

@end
