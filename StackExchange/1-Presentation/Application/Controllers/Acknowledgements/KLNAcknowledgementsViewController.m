//
//  KLNAcknowledgementsViewController.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNAcknowledgementsViewController.h"
#import "Bypass.h"

/**
 *  Constans
 */
#define KLNAcknowledgements_MarkdownFileName @"Pods-StackExchange-acknowledgements"
#define KLNAcknowledgements_MarkdownExtension @"markdown"

@interface KLNAcknowledgementsViewController ()

#pragma mark - Properties

@property (copy, nonatomic, readonly) UIBarButtonItem *buttonClose;

@end

#pragma mark -

@implementation KLNAcknowledgementsViewController {
    UIBarButtonItem *_buttonClose;
}

#pragma mark - Properties

- (UIBarButtonItem *)buttonClose {
    // Init
    if (!_buttonClose) {
        UIImage * imageButtonItem = [IonIcons imageWithIcon:ion_ios_close_outline
                                                       size:KLNStackExchange_BarButtonIconSize
                                                      color:KLNStackExchange_ColorBlue];
        UIBarButtonItem *buttonItem = [KLNUtils barButtonItemWithImage:imageButtonItem
                                                                target:self
                                                                action:@selector(buttonCloseTapped:)];
        _buttonClose = buttonItem;
    }

    return _buttonClose;
}

#pragma mark - Private methods

- (void)loadMarkdown {
    // Markdown document
    NSString * path = [[NSBundle mainBundle] pathForResource:KLNAcknowledgements_MarkdownFileName
                                                      ofType:KLNAcknowledgements_MarkdownExtension];
    NSString * markdown = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    CGRect frame = self.view.frame;
    BPMarkdownView *markdownView = [[BPMarkdownView alloc] initWithFrame:frame markdown:markdown];

    [self.view addSubview:markdownView];
}
- (void)buttonCloseTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupController];
    [self loadMarkdown];
}

#pragma mark - KLNBaseProtocol

- (void)setupController {
    [super setupController];

    self.navigationItem.title = NSLocalizedString(@"Acknowledgements", nil);
    self.navigationItem.leftBarButtonItem = self.buttonClose;
}

@end
