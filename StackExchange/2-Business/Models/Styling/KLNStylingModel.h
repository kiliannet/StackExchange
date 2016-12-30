//
//  KLNStylingModel.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseModel.h"

/**
 *  This type represents some stylings of a site in the Stack Exchange network.
 *  
 *  These stylings are meant to allow developers to subtly vary the presentation of resources
 *  in their applications so as to indicate to users the original source site.
 * 
 *  Applications should be able to gracefully handle these styles changes, though they can 
 *  safely assume that these style changes are infrequent.
 * 
 *  Note that colors can be returned either as six or three digit hex triplets.
 * 
 *  link: https://api.stackexchange.com/docs/types/styling
 */
@interface KLNStylingModel : KLNBaseModel <MTLJSONSerializing>

#pragma mark - Properties

/**
 *  Styling link color.
 */
@property(copy, nonatomic, readonly) NSString *linkColor;

/**
 *  Styling tag background color.
 */
@property(copy, nonatomic, readonly) NSString *tagBackgroundColor;

/**
 *  Styling tag foreground color.
 */
@property(copy, nonatomic, readonly) NSString *tagForegroundColor;

@end
