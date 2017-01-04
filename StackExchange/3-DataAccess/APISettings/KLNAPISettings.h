//
// Created by Eduardo K. Palenzuela Darias on 04/01/17.
// Copyright (c) 2017 Eduardo Palenzuela Darias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLNAPISettings : NSObject

#pragma mark - Properties

@property (copy, nonatomic, readonly) NSString *host;
@property (copy, nonatomic, readonly) NSString *scheme;
@property (copy, nonatomic, readonly) NSString *version;

@end