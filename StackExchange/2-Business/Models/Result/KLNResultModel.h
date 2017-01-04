//
//  KLNResultModel.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

/**
 *  All responses in the Stack Exchange API share a common format, so as to make parsing these responses simpler.
 *
 *  The error_* fields, while technically elligible for filtering, will not actually be excluded in an error case.
 *  This is by design. page and page_size are whatever was passed into the method.
 *
 *  If you're looking to just select total, exclude the items field in favor of excluding all the properties on 
 *  the returned type.
 *
 *  When building filters, this common wrapper object has no name. Refer to it with a leading .,
 *  so the items field would be refered to via .items.
 *
 *  The backoff field is only set when the API detects the request took an unusually long time to run. When it is 
 *  set an application must wait that number of seconds before calling that method again. Note that for the purposes 
 *  of throttling and backoff, the /me routes are considered the same as their /users/{ids} equivalent.
 *
 *  link: https://api.stackexchange.com/docs/wrapper
 */
@interface KLNResultModel : KLNBaseModel <MTLJSONSerializing>

#pragma mark - Properties

/**
 *  Result items.
 */
@property (copy, nonatomic, readonly) NSArray *items;

/**
 *  Result has more items.
 */
@property (copy, nonatomic, readonly) NSNumber *hasMore;

/**
 *  Result quota max.
 */
@property (copy, nonatomic, readonly) NSNumber *quotaMax;

/**
 *  Result quota remaining.
 */
@property (copy, nonatomic, readonly) NSNumber *quotaRemaining;

/**
 *  Result backoff.
 */
@property (copy, nonatomic, readonly) NSNumber *backoff;

/**
 *  Error identifier.
 */
@property (copy, nonatomic, readonly) NSNumber *errorId;

/**
 *  Error message.
 */
@property(copy, nonatomic, readonly) NSString *errorMessage;

/**
 *  Error name.
 */
@property (copy, nonatomic, readonly) NSString *errorName;

#pragma mark - Extra properties

/**
 *  Returns true if there was an error.
 */
@property (assign, nonatomic, readonly) BOOL hasError;

/**
 *  Returns error.
 */
@property (copy, nonatomic, readonly) NSError *error;

@end
