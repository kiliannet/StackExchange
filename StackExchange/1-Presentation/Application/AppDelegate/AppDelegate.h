//
//  AppDelegate.h
//  IT-eBooks_begin
//
//  Created by Eduardo K. Palenzuela Darias on 15/7/15.
//  Copyright (c) 2015 Eduardo K. Palenzuela Darias. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KLNStackExchange_ColorBlue [UIColor colorWithRed:0.149 green:0.290 blue:0.510 alpha:1.000]
#define KLNStackExchange_ColorLightBlue [UIColor colorWithRed:0.286 green:0.388 blue:0.612 alpha:1.000]
#define KLNStackExchange_DefaultIconSize 24.0f
#define KLNStackExchange_BarButtonIconSize 32.0f

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#pragma mark - AppDelegate as Singleton

/**
 *  Singleton para acceder al [[UIApplication sharedApplication] delegate]
 *
 *  @return Instancia de BMSAppDelegate
 */
+ (instancetype)sharedDelegate;

#pragma mark - Properties

/**
 *  UIApplicationDelegate
 */
@property(strong, nonatomic) UIWindow *window;

/**
 *  Permite el acceso a los componentes visuales del Shared.storyboard.
 */
@property(strong, nonatomic, readonly) UIStoryboard *sharedStoryboard;

@end

