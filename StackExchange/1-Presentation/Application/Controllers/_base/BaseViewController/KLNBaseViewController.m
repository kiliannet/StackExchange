//
//  KLNBaseViewController.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseViewController.h"

@implementation KLNBaseViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - KLNBaseProtocol

- (void)setupController {
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
