//
//  KLNResultModel.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNResultModel.h"

/**
 *  Models
 */
#import "KLNQuestionModel.h"

@implementation KLNResultModel

#pragma mark - MTLJSONSerializing

/**
 *  Mapea la correspondencia de los campos devueltos por el JSON con las propuedades de la clase.
 *
 *  @return Mapeo de las propiedades.
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"items"           : @"items",
             @"hasMore"         : @"has_more",
             @"quotaMax"        : @"quota_max",
             @"quotaRemaining"  : @"quota_remaining",
             @"backoff"         : @"backoff",
             @"errorId"         : @"error_id",
             @"errorMessage"    : @"error_message",
             @"errorName"       : @"error_name"};
}

#pragma mark - JSONTransformers

/**
 *  Transforma la propiedad items a NSArray de KLNQuestionModel
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)itemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:KLNQuestionModel.class];
}

#pragma mark - Extra properties

- (BOOL)hasError {
    return self.errorId != nil;
}

- (NSError *)error {
    NSDictionary * userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(self.errorMessage, nil),
            NSLocalizedFailureReasonErrorKey : NSLocalizedString(self.errorName, nil)};

    return [NSError errorWithDomain:@"KLNResultModel" code:[self.errorId integerValue] userInfo:userInfo];
}

@end
