//
//  KLNFactoryService.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 9/10/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import <KLNInject/KLNInjection.h>

/**
 *  Implemented Services
 */
#import "KLNQuestionService.h"

@implementation KLNFactoryService

#pragma mark - Lifecycle

+ (void)initialize {
    [super initialize];
    [KLNInjection registerProtocol:@protocol(KLNQuestionServiceProtocol) asClassType:[KLNQuestionService class]];
}

#pragma mark - Factory method

+ (id)serviceConformToProtocol:(Protocol *) protocol {
    @autoreleasepool {
        return [[KLNInjection resolveProtocol:protocol] new];
    }
}

+ (NSArray *)arrayOfSorts {
    return [KLNQuestionService arrayWithAcceptedSorts];
}

+ (NSArray *)arrayOfOrder {
    return [KLNQuestionService arrayWithOrder];
}

+ (NSString *)stringOfDefaultSiteName {
    return KLNQuestionServiceDefaultSiteName;
}

@end
