//
//  KLNStylingModel.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNStylingModel.h"

@implementation KLNStylingModel

#pragma mark - MTLJSONSerializing

/**
 *  Mapea la correspondencia de los campos devueltos por el JSON con las propuedades de la clase.
 *
 *  @return Mapeo de las propiedades.
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"linkColor"           : @"link_color",
             @"tagBackgroundColor"  : @"tag_background_color",
             @"tagForegroundColor"  : @"tag_foreground_color"};
}

@end
