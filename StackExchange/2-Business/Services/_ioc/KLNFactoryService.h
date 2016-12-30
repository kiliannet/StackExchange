//
//  KLNFactoryService.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 9/10/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Implemented Protocols
 */
#import "KLNQuestionServiceProtocol.h"

/**
 *  Constants
 */
static const NSUInteger KLNServicePage = 1;
static const NSUInteger KLNServicePageSize = 30;

@interface KLNFactoryService : NSObject

#pragma mark - Factory method

/**
 *  Return a new object conform to protocol.
 *
 *  @param protocol protocol to implement.
 *
 *  @return object conform to protocol.
 */
+ (id)serviceConformToProtocol:(Protocol *) protocol;

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
+ (NSArray *)arrayOfSorts;

/**
 *  Return an array with order.
 *
 *  - ascendent     : asc
 *  - descendent    : desc
 *
 *  @return array of order.
 */
+ (NSArray *)arrayOfOrder;

/**
 *  Return default site name of question service.
 */
+ (NSString *)stringOfDefaultSiteName;

@end
