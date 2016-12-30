//
//  KLNSiteModel.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNSiteModel.h"

/**
 *  Models
 */
#import "KLNStylingModel.h"

@implementation KLNSiteModel

#pragma mark - MTLJSONSerializing

/**
 *  Mapea la correspondencia de los campos devueltos por el JSON con las propuedades de la clase.
 *
 *  @return Mapeo de las propiedades.
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"aliases"             : @"aliases",
             @"apiSiteParameter"    : @"api_site_parameter",
             @"audience"            : @"audience",
             @"closedBetaDate"      : @"closed_beta_date",
             @"faviconUrl"          : @"favicon_url",
             @"iconUrlHD"           : @"high_resolution_icon_url",
             @"iconUrl"             : @"icon_url",
             @"launchDate"          : @"launch_date",
             @"logoUrl"             : @"logo_url",
             @"markdownExtensions"  : @"markdown_extensions",
             @"name"                : @"name",
             @"openBetaDate"        : @"open_beta_date",
             @"relatedSites"        : @"related_sites",
             @"state"               : @"site_state",
             @"type"                : @"site_type",
             @"url"                 : @"site_url",
             @"styling"             : @"styling",
             @"twitterAccount"      : @"twitter_account"};
}

#pragma mark - JSONTransformers

/**
 *  Transforma la propiedad closedBetaDate a NSDate
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)closedBetaDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        return date;
    }];
}

/**
 *  Transforma la propiedad launchDate a NSDate
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)launchDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        return date;
    }];
}

/**
 *  Transforma la propiedad openBetaDate a NSDate
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)openBetaDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        return date;
    }];
}

/**
 *  Transforma la propiedad aliases a NSArray de NSString
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)aliasesJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (![value isKindOfClass:NSArray.class]) {
            return nil;
        }

        NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[value count]];

        for (id tag in value) {
            NSString * item = [NSString stringWithFormat:@"%@", tag];
            [tags addObject:item];
        }

        return [tags copy];
    }];
}

/**
 *  Transforma la propiedad markdownExtensions a NSArray de NSString
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)markdownExtensionsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (![value isKindOfClass:NSArray.class]) {
            return nil;
        }

        NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[value count]];

        for (id tag in value) {
            NSString * item = [NSString stringWithFormat:@"%@", tag];
            [tags addObject:item];
        }

        return [tags copy];
    }];
}

/**
 *  Transforma la propiedad faviconUrl a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)faviconUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad iconUrlHD a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)iconUrlHDJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad iconUrl a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)iconUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad logoUrl a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)logoUrlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad url a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad styling a KLNStylingModel.
 *
 *  @return valor transformado.
 */
+ (NSValueTransformer *)stylingJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:KLNStylingModel.class];
}

@end
