//
//  KLNBaseModel.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

@implementation KLNBaseModel

#pragma mark - Class methods

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:kISO8061DateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

        NSString * codeLanguage = [NSLocale preferredLanguages][0];
        NSLocale * currentLocale = [[NSLocale alloc] initWithLocaleIdentifier:codeLanguage];
        [dateFormatter setLocale:currentLocale];
    });

    return dateFormatter;
}

@end
