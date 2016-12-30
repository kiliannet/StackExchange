//
//  KLNRESTEngine.m
//  StackExchange
//
//  Created by Eduardo K. Palenzuela Darias on 24/09/15.
//  Copyright (c) 2015 Eduardo K. Palenzuela Darias. All rights reserved.
//

#import <AFNetworkActivityIndicatorManager.h>
#import "KLNRESTEngine.h"

#define API_BASE_URL @"https://api.stackexchange.com"
#define API_VERSION @"2.2"

static const CGFloat HTTPRequestTimeout = 10.0f; // in seconds

@implementation KLNRESTEngine

#pragma mark - Singleton

+ (KLNRESTEngine *)sharedRESTEngine {
    static KLNRESTEngine *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Activity indicator in status bar
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

        // Session configuration setup
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024     // 10MB. memory cache
                                                          diskCapacity:50 * 1024 * 1024     // 50MB. on disk cache
                                                              diskPath:nil];

        sessionConfiguration.URLCache = cache;
        sessionConfiguration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
        sessionConfiguration.timeoutIntervalForRequest = HTTPRequestTimeout;
        sessionConfiguration.timeoutIntervalForResource = HTTPRequestTimeout;

        // Initialize endpoint
        NSString *baseUrlString = [NSString stringWithFormat:@"%@/%@/", API_BASE_URL, API_VERSION];
        NSURL *baseUrl = [NSURL URLWithString:baseUrlString];
        instance = [[KLNRESTEngine alloc] initWithBaseURL:baseUrl sessionConfiguration:sessionConfiguration];

        // Set serializer JSON
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.responseSerializer = [AFJSONResponseSerializer serializer];

        // Reachability setup
        __weak typeof(instance.operationQueue) weakOperationQueue = instance.operationQueue;

        [[instance reachabilityManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            __block typeof(weakOperationQueue) blockOperationQueue = weakOperationQueue;

            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [blockOperationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    [blockOperationQueue setSuspended:YES];
                    break;
            }
        }];

        [instance.reachabilityManager startMonitoring];
    });

    return instance;
}

@end
