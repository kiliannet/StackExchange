//
//  KLNQuestionModel.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

/**
 *  Deferred declare
 */
@class KLNUserModel;
@class KLNMigrationInfo;

/**
 *  This type represents a question on one of the Stack Exchange sites, such as this famous 
 *  RegEx question.
 *  
 *  This type is heavily inspired by the question page itself, and can optionally return 
 *  comments and answers accordingly.
 *  
 *  The upvoted, downvoted, and favorited fields can only be queried for with an access_token 
 *  with the private_info scope.
 *  
 *  link: https://api.stackexchange.com/docs/types/question
 */
@interface KLNQuestionModel : KLNBaseModel <MTLJSONSerializing>

#pragma mark - Properties

/**
 *  Question identifier
 */
@property(copy, nonatomic, readonly) NSNumber *objectId;

/**
 *  Question title
 */
@property(copy, nonatomic, readonly) NSString *title;

/**
 *  Question is answered
 */
@property(assign, nonatomic, readonly) BOOL isAnswered;

/**
 *  Question view count
 */
@property(copy, nonatomic, readonly) NSNumber *viewCount;

/**
 *  Question answer count
 */
@property(copy, nonatomic, readonly) NSNumber *answerCount;

/**
 *  Question score
 */
@property(copy, nonatomic, readonly) NSNumber *score;

/**
 *  Question last activity date.
 */
@property(copy, nonatomic, readonly) NSDate *lastActivityDate;

/**
 *  Question creation date.
 */
@property(copy, nonatomic, readonly) NSDate *creationDate;

/**
 *  Question last edit date.
 */
@property(copy, nonatomic, readonly) NSDate *lastEditDate;

/**
 *  Question link.
 */
@property(copy, nonatomic, readonly) NSURL *link;

/**
 *  Question accepted answerd id.
 */
@property(copy, nonatomic, readonly) NSNumber *acceptedAnswerId;

/**
 *  Question bounty amount.
 */
@property(copy, nonatomic, readonly) NSNumber *bountyAmount;

/**
 *  Question bounty closes date.
 */
@property(copy, nonatomic, readonly) NSDate *bountyClosesDate;

/**
 *  Question closed date.
 */
@property(copy, nonatomic, readonly) NSDate *closedDate;

/**
 *  Question closed reason.
 */
@property(copy, nonatomic, readonly) NSString *closedReason;

/**
 *  Question community owned date.
 */
@property(copy, nonatomic, readonly) NSDate *communityOwnedDate;

/**
 *  Question locked date.
 */
@property(copy, nonatomic, readonly) NSDate *lockedDate;

/**
 *  Question migrated from.
 */
@property(copy, nonatomic, readonly) KLNMigrationInfo *migratedFrom;

/**
 *  Question migrated to.
 */
@property(copy, nonatomic, readonly) KLNMigrationInfo *migratedTo;

/**
 *  Question protected date.
 */
@property(copy, nonatomic, readonly) NSDate *protectedDate;

/**
 *  Question tags
 */
@property(copy, nonatomic, readonly) NSArray *tags;

/**
 *  Question owner
 */
@property(copy, nonatomic, readonly) KLNUserModel *owner;

@end
