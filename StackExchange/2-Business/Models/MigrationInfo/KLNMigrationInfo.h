//
//  KLNMigrationInfo.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

/**
 *  Deferred declare
 */
@class KLNSiteModel;

/**
 *  This type represents a question's migration to or from a different site in the Stack Exchange network.
 * 
 *  link: https://api.stackexchange.com/docs/types/migration-info
 */
@interface KLNMigrationInfo : KLNBaseModel <MTLJSONSerializing>

#pragma mark - Properties

/**
 *  MigrationInfo on date.
 */
@property(copy, nonatomic, readonly) NSDate *onDate;

/**
 *  MigrationInfo other site.
 */
@property(copy, nonatomic, readonly) KLNSiteModel *otherSite;

/**
 *  MigrationInfo question indentifier.
 */
@property(copy, nonatomic, readonly) NSNumber *questionId;

@end
