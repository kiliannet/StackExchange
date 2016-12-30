//
//  KLNBaseTableViewController.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseTableViewController.h"

@implementation KLNBaseTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // Botón de volver sin texto
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

#pragma mark - KLNBaseProtocol

- (void)setupController {
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
