//
//  KLNMigrationInfo.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNMigrationInfo.h"

/**
 *  Models
 */
#import "KLNSiteModel.h"

@implementation KLNMigrationInfo

#pragma mark - MTLJSONSerializing

/**
 *  Mapea la correspondencia de los campos devueltos por el JSON con las propuedades de la clase.
 *
 *  @return Mapeo de las propiedades.
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"onDate"      : @"on_date",
             @"otherSite"   : @"other_site",
             @"questionId"  : @"question_id"};
}

#pragma mark - JSONTransformers

/**
 *  Transforma la propiedad onDate a NSDate
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)onDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        return date;
    }];
}

/**
 *  Transforma la propiedad otherSite a KLNSiteModel.
 *
 *  @return valor transformado.
 */
+ (NSValueTransformer *)otherSiteJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:KLNSiteModel.class];
}

@end
