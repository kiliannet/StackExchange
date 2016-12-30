//
//  KLNQuestionService.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNQuestionService.h"

/**
 *  Models
 */
#import "KLNResultModel.h"

#define METHOD_QUESTIONS @"questions"

NSString *const KLNQuestionServiceDefaultSiteName = @"stackoverflow";

@implementation KLNQuestionService

#pragma mark - KLNQuestionsServiceProtocol

- (void)questionBySite:(NSString *)site
              fromDate:(NSNumber *)fromDate
                toDate:(NSNumber *)toDate
                 order:(NSString *)order
                   min:(NSNumber *)min
                   max:(NSNumber *)max
                  sort:(NSString *)sort
                tagged:(NSArray *)tagged
                  page:(NSNumber *)page
              pageSize:(NSNumber *)pageSize
              callback:(CallbackServiceWithObject)callback {
    // Get URL.
    NSString *url = [KLNQuestionService stringWithSite:site
                                              fromDate:fromDate
                                                toDate:toDate
                                                 order:order
                                                   min:min
                                                   max:max
                                                  sort:sort
                                                tagged:tagged
                                                  page:page
                                              pageSize:pageSize];

    [self.restEngine GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error = nil;
        KLNResultModel *result = [MTLJSONAdapter modelOfClass:KLNResultModel.class
                                           fromJSONDictionary:responseObject error:&error];

        if (error) {
            callback(nil, error);
            return;
        }

        if (result.hasError) {
            callback(nil, result.error);
            return;
        }

        callback(result, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        callback(nil, error);
    }];
}

+ (NSArray *)arrayWithAcceptedSorts {
    return @[@"activity",
             @"creation",
             @"votes",
             @"hot",
             @"week",
             @"month"];
}

+ (NSArray *)arrayWithOrder {
    return @[@"asc",
             @"desc"];
}

#pragma mark - Helpers

/**
 *  Devuelve la URL según los parámetros enviados.
 *
 *  @param site     site name
 *  @param fromDate from date
 *  @param toDate   to date
 *  @param order    order
 *  @param min      min
 *  @param max      max
 *  @param sort     sort
 *  @param tagged   tagged
 *  @param page     page
 *  @param pageSize page size
 *
 *  @return URL de la petición.
 */
+ (NSString *)stringWithSite:(NSString *)site
                    fromDate:(NSNumber *)fromDate
                      toDate:(NSNumber *)toDate
                       order:(NSString *)order
                         min:(NSNumber *)min
                         max:(NSNumber *)max
                        sort:(NSString *)sort
                      tagged:(NSArray *)tagged
                        page:(NSNumber *)page
                    pageSize:(NSNumber *)pageSize {
    // Comprobamos que los campos obligatorios están presentes
    NSParameterAssert(site);
    NSParameterAssert(order);
    NSParameterAssert(sort);

    // Array que acepta min y max.
    NSArray *accepted = [[KLNQuestionService arrayWithAcceptedSorts] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];

    // Componemos la URL por defecto y agregamos parámetros en caso de que existan.
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@?site=%@&order=%@&sort=%@", METHOD_QUESTIONS, site, order, sort];
    [url appendFormat:@"%@", (fromDate == nil)  ? @"" : [NSString stringWithFormat:@"&fromdate=%@", fromDate]];
    [url appendFormat:@"%@", (toDate == nil)    ? @"" : [NSString stringWithFormat:@"&todate=%@", toDate]];
    [url appendFormat:@"%@", (page == nil)      ? @"" : [NSString stringWithFormat:@"&page=%@", page]];
    [url appendFormat:@"%@", (pageSize == nil)  ? @"" : [NSString stringWithFormat:@"&pagesize=%@", pageSize]];

    [url appendFormat:@"%@", (tagged != nil && tagged.count > 0)
            ? [NSString stringWithFormat:@"&tagged=%@", [tagged componentsJoinedByString:@";"]]
            : @""];

    // max and min
    if ([accepted containsObject:sort]) {
        [url appendFormat:@"%@", (max == nil) ? @"" : [NSString stringWithFormat:@"&max=%@", max]];
        [url appendFormat:@"%@", (min == nil) ? @"" : [NSString stringWithFormat:@"&min=%@", min]];
    }

    return [[url lowercaseString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
