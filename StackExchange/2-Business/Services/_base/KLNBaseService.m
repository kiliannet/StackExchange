//
//  KLNBaseService.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseService.h"

@implementation KLNBaseService

#pragma mark - Properties

- (KLNRESTEngine *)restEngine {
    static KLNRESTEngine *restEngine;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        restEngine = [KLNRESTEngine sharedRESTEngine];
    });

    return restEngine;
}

@end
