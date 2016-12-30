//
//  AppDelegate.m
//  StackExchange
//
//  Created by Eduardo K. Palenzuela Darias on 15/7/15.
//  Copyright (c) 2015 Eduardo K. Palenzuela Darias. All rights reserved.
//

#import "MZFormSheetController.h"

@implementation AppDelegate {
    UIStoryboard *_sharedStoryboard;
}

#pragma mark - AppDelegate as Singleton

+ (instancetype)sharedDelegate {
    static AppDelegate *instance;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    });

    return instance;
}

#pragma mark - Storyboards

- (UIStoryboard *)sharedStoryboard {
    // Init
    if (!_sharedStoryboard) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Shared" bundle:nil];
        _sharedStoryboard = storyboard;
    }

    return _sharedStoryboard;
}

#pragma mark - Private methods

- (void)setupAppearance {
    // NavigationBar font color
    [[UINavigationBar appearance] setTintColor:KLNStackExchange_ColorBlue];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : KLNStackExchange_ColorBlue}];

    // MZFormSheetController
    [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:NO];
    [[MZFormSheetBackgroundWindow appearance] setWindowLevel:MZFormSheetBackgroundWindowLevelBelowStatusBar];
}

#pragma mark - Livecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupAppearance];

    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
