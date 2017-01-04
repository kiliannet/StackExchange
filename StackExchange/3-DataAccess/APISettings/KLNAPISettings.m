//
// Created by Eduardo K. Palenzuela Darias on 04/01/17.
// Copyright (c) 2017 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNAPISettings.h"

@interface KLNAPISettings() {
    NSDictionary *_stackExchangeValues;
}

@property (copy, nonatomic, readonly) NSDictionary *stackExchangeValues;

@end

@implementation KLNAPISettings

#pragma mark - Public properties

- (NSString *)host {
    return self.stackExchangeValues[@"Host"];
}
- (NSString *)scheme {
    return self.stackExchangeValues[@"Scheme"];
}
- (NSString *)version {
    return [NSString stringWithFormat:@"/%@", self.stackExchangeValues[@"Version"]];
}

#pragma mark - Private properties

- (NSDictionary *)stackExchangeValues {
    if (!_stackExchangeValues) {
        NSDictionary *values = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Stack Exchange API"];
        _stackExchangeValues = values;
    }

    return _stackExchangeValues;
}

@end