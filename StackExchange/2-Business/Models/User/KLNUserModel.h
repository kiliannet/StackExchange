//
//  KLNUserModel.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

/**
 *  This type represents a user, but omits many of the fields found on the full User type.
 *
 *  This type is mostly analogous to the "user card" found on many pages (like the question page)
 *  on a Stack Exchange site.
 * 
 *  link: https://api.stackexchange.com/docs/types/shallow-user
 */
@interface KLNUserModel : KLNBaseModel <MTLJSONSerializing>

#pragma mark - Properties

/**
 *  User identifier.
 */
@property (copy, nonatomic, readonly) NSNumber *objectId;

/**
 *  One of unregistered, registered, moderator, or does_not_exist.
 */
@property (copy, nonatomic, readonly) NSString *type;

/**
 *  User reputation.
 */
@property (copy, nonatomic, readonly) NSNumber *reputation;

/**
 *  User accept rate.
 */
@property (copy, nonatomic, readonly) NSNumber *acceptRate;

/**
 *  User profile image url.
 */
@property (copy, nonatomic, readonly) NSURL *profileImage;

/**
 *  User name.
 */
@property (copy, nonatomic, readonly) NSString *name;

/**
 *  User link.
 */
@property (copy, nonatomic, readonly) NSURL *link;

@end
