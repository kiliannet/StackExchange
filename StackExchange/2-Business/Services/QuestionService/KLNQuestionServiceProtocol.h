//
//  KLNQuestionServiceProtocol.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseService.h"

/**
 *  Question Service Protocol.
 */
@protocol KLNQuestionServiceProtocol <NSObject>

#pragma mark - Helpers

/**
 *  Return an array with accepted sorts:
 *
 *  - activity  : last_activity_date.
 *  - creation  : creation_date.
 *  - votes     : score.
 *  - hot       : by the formula ordering the hot tab. Does not accept min or max.
 *  - week      : by the formula ordering the week tab. Does not accept min or max.
 *  - month     : by the formula ordering the month tab. Does not accept min or max.
 *
 *  @return array of sorts.
 */
+ (NSArray *)arrayWithAcceptedSorts;

/**
 *  Return an array with order.
 *
 *  - ascendent     : asc
 *  - descendent    : desc
 *
 *  @return array of order.
 */
+ (NSArray *)arrayWithOrder;

#pragma mark - Methods

/**
 *  Gets all the questions on the site.
 *
 *  This method allows you make fairly flexible queries across the entire corpus of questions on a site.
 *  For example, getting all questions asked in the the week of Jan 1st 2011 with scores of 10 or more is
 *  a single query with parameters sort=votes&min=10&fromdate=1293840000&todate=1294444800.
 *
 *  To constrain questions returned to those with a set of tags, use the tagged parameter with a semi-colon
 *  delimited list of tags. This is an and contraint, passing tagged=c;java will return only those questions
 *  with both tags. As such, passing more than 5 tags will always return zero results.
 *
 *  The sorts accepted by this method operate on the follow fields of the question object:
 *
 *  - activity  : last_activity_date.
 *  - creation  : creation_date.
 *  - votes     : score.
 *  - hot       : by the formula ordering the hot tab. Does not accept min or max.
 *  - week      : by the formula ordering the week tab. Does not accept min or max.
 *  - month     : by the formula ordering the month tab. Does not accept min or max.
 *
 *  The Stack Exchange API provides the sort, min, max, fromdate, and todate parameters on many methods to allow
 *  for more complicated queries. min and max specify the range of a field must fall in (that field being
 *  specified by sort) to be returned, while fromdate and todate always define the range of creation_date.
 *  Think these parameters as defining two "windows" in which data must fit to be returned.
 *
 *  All dates in the Stack Exchange API are in unix epoch time, which is the number of seconds since midnight UTC
 *  January 1st, 1970. The Stack Exchange API does not accept or return fractional times, everything should be
 *  rounded to the nearest whole second.
 *
 *  @param site     name of site (default Stack Overflow: stackoverflow)
 *  @param fromDate define the range of creation_date (from date)
 *  @param toDate   define the range of creation_date (to date)
 *  @param order    order of results (asc / desc)
 *  @param sort     accepted sort (default activity)
 *  @param tagged   array of tags (max 5)
 *  @param page     page start at (default 1)
 *  @param pageSize page size can be any value between 0 and 100 (default 30)
 *  @param callback block of result - CallbackServiceWithObject(id item, NSError *error);
 */
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
              callback:(CallbackServiceWithObject)callback;

@end
