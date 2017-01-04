//
//  KLNQuestionService.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNQuestionService.h"
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

    NSDictionary *parameters = [KLNQuestionService dictionaryWithSite:site
                                                             fromDate:fromDate
                                                               toDate:toDate
                                                                order:order
                                                                  min:min
                                                                  max:max
                                                                 sort:sort
                                                               tagged:tagged
                                                                 page:page
                                                             pageSize:pageSize];

    [self.restEngine GET:METHOD_QUESTIONS parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
 *  Returns a NSDictionary with parameters.
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
 *  @return NSDictionary with parameters.
 */
+ (NSDictionary *)dictionaryWithSite:(NSString *)site
                            fromDate:(NSNumber *)fromDate
                              toDate:(NSNumber *)toDate
                               order:(NSString *)order
                                 min:(NSNumber *)min
                                 max:(NSNumber *)max
                                sort:(NSString *)sort
                              tagged:(NSArray *)tagged
                                page:(NSNumber *)page
                            pageSize:(NSNumber *)pageSize {
    NSParameterAssert(site);
    NSParameterAssert(order);
    NSParameterAssert(sort);

    NSMutableDictionary *parameters = [@{
            @"site": site,
            @"order": order,
            @"sort": sort
    } mutableCopy];

    parameters[@"fromdate"] = (fromDate == nil) ? @"" : fromDate;
    parameters[@"todate"] = (toDate == nil) ? @"" : toDate;
    parameters[@"page"] = (page == nil) ? @"" : page;
    parameters[@"pagesize"] = (pageSize == nil) ? @"" : pageSize;
    parameters[@"tagged"] = (tagged != nil && tagged.count > 0) ? [tagged componentsJoinedByString:@";"] : @"";

    // Max and Min accepted
    NSArray *accepted = [[KLNQuestionService arrayWithAcceptedSorts] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)]];

    if ([accepted containsObject:sort]) {
        parameters[@"max"] = (max == nil) ? @"" : max;
        parameters[@"min"] = (min == nil) ? @"" : min;
    }

    return [parameters copy];
}

@end
