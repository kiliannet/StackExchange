//
//  KLNBaseService.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNRESTEngine.h"

/**
 *  Bloque que devuelve un conjuto de resultados del tipo NSArray.
 *
 *  @param items Elementos devueltos.
 *  @param error Error producido.
 */
typedef void (^CallbackServiceWithArray)(NSArray *items, NSError *error);

/**
 *  Bloque completion para cuando devolvemos un objeto tipado.
 *
 *  @param item  Elemento devuleto.
 *  @param error Error producido.
 */
typedef void (^CallbackServiceWithObject)(id item, NSError *error);

/**
 *  Base service
 */
@interface KLNBaseService : NSObject

/**
 *  Objeto de acceso a datos.
 */
@property (copy, nonatomic, readonly) KLNRESTEngine *restEngine;

@end
