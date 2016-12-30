//
//  KLNSiteModel.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

/**
 *  Deferred declare
 */
@class KLNStylingModel;

/**
 *  This type represents a site in the Stack Exchange network.
 *
 *  link: https://api.stackexchange.com/docs/types/site
 */
@interface KLNSiteModel : KLNBaseModel <MTLJSONSerializing>

#pragma mark - Properties

/**
 *  Site aliases.
 */
@property(copy, nonatomic, readonly) NSArray *aliases;

/**
 *  Site api parameter.
 */
@property(copy, nonatomic, readonly) NSString *apiSiteParameter;

/**
 *  Site audience.
 */
@property(copy, nonatomic, readonly) NSString *audience;

/**
 *  Site closed date.
 */
@property(copy, nonatomic, readonly) NSDate *closedBetaDate;

/**
 *  Site favicon url.
 */
@property(copy, nonatomic, readonly) NSURL *faviconUrl;

/**
 *  Site icon url high resolution.
 */
@property(copy, nonatomic, readonly) NSURL *iconUrlHD;

/**
 *  Site icon url.
 */
@property(copy, nonatomic, readonly) NSURL *iconUrl;

/**
 *  Site launch date.
 */
@property(copy, nonatomic, readonly) NSDate *launchDate;

/**
 *  Site logo url.
 */
@property(copy, nonatomic, readonly) NSURL *logoUrl;

/**
 *  Array of 'MathJax', 'Prettify', 'Balsamiq' or 'jTab' strings, but new options may be added.
 */
@property(copy, nonatomic, readonly) NSArray *markdownExtensions;

/**
 *  Site name.
 */
@property(copy, nonatomic, readonly) NSString *name;

/**
 *  Site open beta date.
 */
@property(copy, nonatomic, readonly) NSDate *openBetaDate;

/**
 *  Array of related_sites.
 */
@property(copy, nonatomic, readonly) NSArray *relatedSites;

/**
 *  One of normal, closed_beta, open_beta, or linked_meta.
 */
@property(copy, nonatomic, readonly) NSString *state;

/**
 *  One of main_site or meta_site, but new options may be added.
 */
@property(copy, nonatomic, readonly) NSString *type;

/**
 *  Site url.
 */
@property(copy, nonatomic, readonly) NSURL *url;

/**
 *  Site styling.
 */
@property(copy, nonatomic, readonly) KLNStylingModel *styling;

/**
 *  Site twitter account.
 */
@property(copy, nonatomic, readonly) NSString *twitterAccount;

@end
