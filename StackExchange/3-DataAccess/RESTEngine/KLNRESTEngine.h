//
//  KLNRESTEngine.h
//  	
//
//  Created by Eduardo K. Palenzuela Darias on 24/09/15.
//  Copyright (c) 2015 Eduardo K. Palenzuela Darias. All rights reserved.
//

#import <AFNetworking.h>

@interface KLNRESTEngine : AFHTTPSessionManager

#pragma mark - Singleton

/**
 *  Método singleton que devuelve una única instancia de KLNRESTEngine.
 *
 *  @return Devuelve una instancia de KLNRESTEngine.
 */
+ (KLNRESTEngine *)sharedRESTEngine;

@end
