//
//  KLNBaseModel.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  Constants
 */
#define kISO8061DateFormat @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
#define kISO8601DateFormat @"yyyy-MM-dd'T'HH:mm:ss'Z'"
#define kRFC822DateFormat  @"EEE, dd MMM yyyy HH:mm:ss z"
#define kDateStampFormat   @"yyyyMMdd"
#define kDateTimeFormat    @"yyyyMMdd'T'HHmmss'Z'"

@interface KLNBaseModel : MTLModel

/**
 *  Devuelve el formato de fecha para el sistema.
 *
 *  @return Objeto preparado para formatear fechas.
 */
+ (NSDateFormatter *)dateFormatter;

@end
