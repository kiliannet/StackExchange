//
//  KLNQuestionModel.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNQuestionModel.h"

/**
 *  Models
 */
#import "KLNUserModel.h"
#import "KLNMigrationInfo.h"

@implementation KLNQuestionModel

#pragma mark - MTLJSONSerializing

/**
 *  Mapea la correspondencia de los campos devueltos por el JSON con las propiedades de la clase.
 *
 *  @return Mapeo de las propiedades.
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"acceptedAnswerId"    : @"accepted_answer_id",
             @"answerCount"         : @"answer_count",
             @"bountyAmount"        : @"bounty_amount",
             @"bountyClosesDate"    : @"bounty_closes_date",
             @"closedDate"          : @"closed_date",
             @"closedReason"        : @"closed_reason",
             @"communityOwnedDate"  : @"community_owned_date",
             @"creationDate"        : @"creation_date",
             @"isAnswered"          : @"is_answered",
             @"lastActivityDate"    : @"last_activity_date",
             @"lastEditDate"        : @"last_edit_date",
             @"link"                : @"link",
             @"lockedDate"          : @"locked_date",
             @"migratedFrom"        : @"migrated_from",
             @"migratedTo"          : @"migrated_to",
             @"owner"               : @"owner",
             @"protectedDate"       : @"protected_date",
             @"objectId"            : @"question_id",
             @"score"               : @"score",
             @"tags"                : @"tags",
             @"title"               : @"title",
             @"viewCount"           : @"view_count"};
}

#pragma mark - JSONTransformers

/**
 *  Transforma la propiedad link a NSURL.
 *
 *  @return Valor transformado.
 */
+ (NSValueTransformer *)linkJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

/**
 *  Transforma la propiedad tags a NSArray de NSString.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)tagsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (![value isKindOfClass:NSArray.class]) {
            return nil;
        }

        NSMutableArray *tags = [NSMutableArray arrayWithCapacity:[value count]];

        for (id tag in value) {
            // Force cast to NSString
            NSString * item = [NSString stringWithFormat:@"%@", tag];
            [tags addObject:item];
        }

        return [tags copy];
    }];
}

/**
 *  Transforma la propiedad creationDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)creationDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad bountyClosesDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)bountyClosesDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad closedDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)closedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad communityOwnedDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)communityOwnedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad lastActivityDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)lastActivityDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad lastEditDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)lastEditDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad lockedDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)lockedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        // Force cast timestamp to NSDate
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];

        return date;
    }];
}

/**
 *  Transforma la propiedad protectedDate a NSDate.
 *
 *  @return valor transformado
 */
+ (NSValueTransformer *)protectedDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        return date;
    }];
}

/**
 *  Transforma la propiedad migratedFrom a KLNMigrationInfo.
 *
 *  @return valor transformado.
 */
+ (NSValueTransformer *)migratedFromJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:KLNMigrationInfo.class];
}

/**
 *  Transforma la propiedad migratedTo a KLNMigrationInfo.
 *
 *  @return valor transformado.
 */
+ (NSValueTransformer *)migratedToJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:KLNMigrationInfo.class];
}

/**
 *  Transforma la propiedad owner a KLNUserModel.
 *
 *  @return valor transformado.
 */
+ (NSValueTransformer *)ownerJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:KLNUserModel.class];
}

@end
