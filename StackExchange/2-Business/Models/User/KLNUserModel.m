//
//  KLNUserModel.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNUserModel.h"

@implementation KLNUserModel

#pragma mark - MTLJSONSerializing

/**
 *  Mapea la correspondencia de los campos devueltos por el JSON con las propuedades de la clase.
 *
 *  @return Mapeo de las propiedades.
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"objectId"        : @"user_id",
             @"type"            : @"user_type",
             @"reputation"      : @"reputation",
             @"acceptRate"      : @"accept_rate",
             @"profileImage"    : @"profile_image",
             @"name"            : @"display_name",
             @"link"            : @"link"};
}

#pragma mark - JSONTransformers

/**
 *  Transforma la propiedad profileImage a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)profileImageJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad link a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)linkJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
