//
//  KLNFilterController.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 24/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNAcknowledgementsViewController.h"
#import "KLNFilterController.h"
#import "KLNPickerViewController.h"
#import "KLNResultModel.h"
#import "KLNResultsViewController.h"
#import "MZFormSheetController.h"
#import "KLNQuestionServiceProtocol.h"

typedef NS_ENUM(NSUInteger, KLNFilterCell) {
    KLNFilterCellFromDate = 0,
    KLNFilterCellToDate,
    KLNFilterCellSort,
    KLNFilterCellMax,
    KLNFilterCellMin,
    KLNFilterCellTags,
    KLNFilterCellOrder
};

@interface KLNFilterController () <KLNPickerViewControllerDelegate>

#pragma mark - Properties

@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) NSString *sort;
@property (strong, nonatomic) NSString *tags;
@property (strong, nonatomic) NSString *order;
@property (strong, nonatomic) id max;
@property (strong, nonatomic) id min;

@property (copy, nonatomic, readonly) UIBarButtonItem *buttonAcknowledgements;
@property (copy, nonatomic, readonly) UIBarButtonItem *buttonRefresh;
@property (copy, nonatomic, readonly) UIBarButtonItem *buttonLoading;
@property (copy, nonatomic, readonly) UIRefreshControl *refresh;

@property (assign, nonatomic, readonly) BOOL isNotAcceptedMaxOrMin;

@property (strong, nonatomic, readonly) id <KLNQuestionServiceProtocol> service;

@end

#pragma mark -

@implementation KLNFilterController {
    UIBarButtonItem *_buttonAcknowledgements;
    UIBarButtonItem *_buttonRefresh;
    UIBarButtonItem *_buttonLoading;
    UIRefreshControl *_refresh;
    id <KLNQuestionServiceProtocol> _service;
}

#pragma mark - Properties

- (UIBarButtonItem *)buttonAcknowledgements {
    // Init
    if (!_buttonAcknowledgements) {
        UIImage * imageButtonItem = [IonIcons imageWithIcon:ion_ios_information_outline
                                                       size:KLNStackExchange_BarButtonIconSize
                                                      color:KLNStackExchange_ColorBlue];
        UIBarButtonItem *buttonItem = [KLNUtils barButtonItemWithImage:imageButtonItem
                                                                target:self
                                                                action:@selector(buttonAcknowledgementsTapped:)];
        _buttonAcknowledgements = buttonItem;
    }

    return _buttonAcknowledgements;
}
- (UIBarButtonItem *)buttonRefresh {
    // Init
    if (!_buttonRefresh) {
        UIImage * imageButtonItem = [IonIcons imageWithIcon:ion_ios_refresh_outline
                                                       size:KLNStackExchange_BarButtonIconSize
                                                      color:KLNStackExchange_ColorBlue];
        UIBarButtonItem *buttonItem = [KLNUtils barButtonItemWithImage:imageButtonItem
                                                                target:self
                                                                action:@selector(buttonRefreshTapped:)];
        _buttonRefresh = buttonItem;
    }

    return _buttonRefresh;
}
- (UIBarButtonItem *)buttonLoading {
    // Init
    if (!_buttonLoading) {
        UIBarButtonItem *buttonItem = [KLNUtils barButtonItemWithActivityIndicatorWithColor:KLNStackExchange_ColorBlue];
        _buttonLoading = buttonItem;
    }

    return _buttonLoading;
}
- (UIRefreshControl *)refresh {
    // Init
    if (!_refresh) {
        UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
        [refresh addTarget:self action:@selector(setDefaultValues) forControlEvents:UIControlEventValueChanged];
        _refresh = refresh;
    }

    return _refresh;
}

- (BOOL)isNotAcceptedMaxOrMin {
    return ([self.sort isEqualToString:@"hot"] ||
            [self.sort isEqualToString:@"week"] ||
            [self.sort isEqualToString:@"month"]);
}

- (id <KLNQuestionServiceProtocol>)service {
    if (!_service) {
        _service = [KLNFactoryService serviceConformToProtocol:@protocol(KLNQuestionServiceProtocol)];
    }

    return _service;
}

#pragma mark - Private methods

- (void)setDefaultValues {
    self.fromDate = nil;
    self.toDate = nil;
    self.sort = [KLNFactoryService arrayOfSorts][0];
    self.max = nil;
    self.min = nil;
    self.tags = nil;
    self.order = [KLNFactoryService arrayOfOrder][0];
    
    [self.tableView reloadData];
    [self.refresh endRefreshing];
}
- (void)showAcknowledgements {
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:[KLNAcknowledgementsViewController new]];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}
- (void)showInputMaxOrMinOnRow:(NSInteger)row {
    NSString *title = (KLNFilterCell) row == KLNFilterCellMax ? NSLocalizedString(@"Max", nil) : NSLocalizedString(@"Min", nil);
    NSString *message = [NSString stringWithFormat:NSLocalizedString(@"Enter %@ value", nil), title];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        __block typeof(weakSelf) blockSelf = weakSelf;

        KLNFilterCell filterCell = (KLNFilterCell) row;
        
        if (filterCell == KLNFilterCellMax) {
            blockSelf.max = alert.textFields[0].text;
        } else {
            blockSelf.min = alert.textFields[0].text;
        }
        
        [blockSelf.tableView reloadData];
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)showInputTags {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tags"
                                                                   message:NSLocalizedString(@"Enter tags separated by spaces", nil)
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
    }];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        __block typeof(weakSelf) blockSelf = weakSelf;

        NSString *value = [alert.textFields[0].text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        blockSelf.tags = (value.length > 0)
                ? value
                : nil;

        [blockSelf.tableView reloadData];
    }];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)executeRequest {
    // Loading
    self.navigationItem.rightBarButtonItem = self.buttonLoading;
    
    // Prepare min
    NSNumber * min;
    if (self.min) {
        min = [self.min isKindOfClass:[NSDate class]]
        ? @((long) [self.min timeIntervalSince1970])
        : @([self.min integerValue]);
    }
    
    // Prepare max
    NSNumber * max;
    if (self.max) {
        max = [self.max isKindOfClass:[NSDate class]]
        ? @((long) [self.max timeIntervalSince1970])
        : @([self.max integerValue]);
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self.service questionBySite:[KLNFactoryService stringOfDefaultSiteName]
                        fromDate:self.fromDate == nil ? nil : @((long) [self.fromDate timeIntervalSince1970])
                          toDate:self.toDate == nil ? nil : @((long) [self.toDate timeIntervalSince1970])
                           order:self.order
                             min:min
                             max:max
                            sort:self.sort
                          tagged:self.tags == nil ? nil : [self.tags componentsSeparatedByString:@" "]
                            page:@(KLNServicePage)
                        pageSize:@(KLNServicePageSize)
                        callback:^(KLNResultModel *item, NSError *error) {
                            __block typeof(weakSelf) blockSelf = weakSelf;

                            blockSelf.navigationItem.rightBarButtonItem = blockSelf.buttonRefresh;

                            // Check error
                            if (error) {
                                [KLNUtils showNotificationAlertWithMessage:error.localizedDescription
                                                          inViewController:blockSelf];
                                return;
                            }

                            // Check row counts
                            if (item.items.count > 0) {
                                // Show results
                                [blockSelf performSegueWithIdentifier:@"ResultsSegue" sender:item];
                                return;
                            }
                        
                            // No results
                            [KLNUtils showNotificationWarningWithMessage:NSLocalizedString(@"No results", nil)
                                                        inViewController:blockSelf];
                        }];
}
- (void)evaluateSort {
    // Tienen que ser numéricos
    if ([self.sort isEqualToString:@"votes"] && ([self.min isKindOfClass:[NSDate class]] || [self.max isKindOfClass:[NSDate class]])) {
        self.min = nil;
        self.max = nil;
        
        return;
    }
    
    if (self.isNotAcceptedMaxOrMin) {
        self.min = nil;
        self.max = nil;
        
        return;
    }
    
    if (![self.min isKindOfClass:[NSDate class]] || ![self.max isKindOfClass:[NSDate class]]) {
        self.min = nil;
        self.max = nil;
    }
}
- (void)buttonAcknowledgementsTapped:(id)sender {
    [self showAcknowledgements];
}
- (void)buttonRefreshTapped:(id)sender {
    [self executeRequest];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDefaultValues];
    [self setupController];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    KLNResultsViewController *resultsView = segue.destinationViewController;
    resultsView.items = [(KLNResultModel *) sender items];
}

#pragma mark - KLNBaseProtocol

- (void)setupController {
    [super setupController];

    self.navigationItem.leftBarButtonItem = self.buttonAcknowledgements;
    self.navigationItem.rightBarButtonItem = self.buttonRefresh;

    [self.tableView addSubview:self.refresh];

    // Logo en la barra de navegación
    UIImage * imageShoppiicLogo = [UIImage imageNamed:@"stack-exchange-logo-text"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:imageShoppiicLogo];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Imagen asociada
    NSString * iconName = nil;
    KLNFilterCell filterCell = (KLNFilterCell) indexPath.row;

    // Comprobamos qué celda se va a visualizar
    switch (filterCell) {
        case KLNFilterCellFromDate:
            cell.textLabel.text = NSLocalizedString(@"From date", nil);
            cell.detailTextLabel.text = (self.fromDate == nil) ? @"" : [[KLNUtils dateFormatter] stringFromDate:self.fromDate];
            iconName = ion_ios_calendar_outline;
            break;
        case KLNFilterCellToDate:
            cell.textLabel.text = NSLocalizedString(@"To date", nil);
            cell.detailTextLabel.text = (self.toDate == nil) ? @"" : [[KLNUtils dateFormatter] stringFromDate:self.toDate];
            iconName = ion_ios_calendar_outline;
            break;
        case KLNFilterCellSort:
            cell.textLabel.text = NSLocalizedString(@"Sort", nil);
            cell.detailTextLabel.text = (self.sort == nil) ? @"" : self.sort;
            iconName = ion_arrow_swap;
            break;
        case KLNFilterCellMax:
            cell.textLabel.text = NSLocalizedString(@"Max", nil);
            cell.detailTextLabel.text = [self.max isKindOfClass:[NSDate class]] ? [[KLNUtils dateFormatter] stringFromDate:self.max] : self.max;
            iconName = ion_ios_plus_empty;
            break;
        case KLNFilterCellMin:
            cell.textLabel.text = NSLocalizedString(@"Min", nil);
            cell.detailTextLabel.text = [self.min isKindOfClass:[NSDate class]] ? [[KLNUtils dateFormatter] stringFromDate:self.min] : self.min;
            iconName = ion_ios_minus_empty;
            break;
        case KLNFilterCellTags:
            cell.textLabel.text = NSLocalizedString(@"Tags", nil);
            cell.detailTextLabel.text = (self.tags == nil) ? @"" : self.tags;
            iconName = ion_ios_pricetags_outline;
            break;
        case KLNFilterCellOrder:
            cell.textLabel.text = NSLocalizedString(@"Order", nil);
            cell.detailTextLabel.text = (self.order == nil) ? @"" : self.order;
            iconName = [self.order isEqualToString:@"asc"] ? ion_arrow_up_b : ion_arrow_down_b;
            break;
    }

    // Creamos el icono
    UIImage * icon = [IonIcons imageWithIcon:iconName
                                        size:KLNStackExchange_DefaultIconSize
                                       color:KLNStackExchange_ColorBlue];
    cell.imageView.image = icon;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Controlamos la celda pulsada
    KLNFilterCell filterCell = (KLNFilterCell) indexPath.row;

    if (filterCell == KLNFilterCellTags) {
        [self showInputTags];
        return;
    }

    BOOL isMaxOrMinCell = (filterCell == KLNFilterCellMax || filterCell == KLNFilterCellMin);

    if ([self.sort isEqualToString:@"votes"] && isMaxOrMinCell) {
        [self showInputMaxOrMinOnRow:indexPath.row];
        return;
    }

    if (self.isNotAcceptedMaxOrMin && isMaxOrMinCell) {
        [KLNUtils showNotificationWarningWithMessage:NSLocalizedString(@"The selected Sort doen't accept Min or Max", nil)
                                    inViewController:self];
        [self.tableView reloadData];
        return;
    }

    // Cargamos la vista del pickerview
    UINavigationController *nc = [[AppDelegate sharedDelegate].sharedStoryboard
            instantiateViewControllerWithIdentifier:[KLNPickerViewController reuseIdentifier]];

    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:nc];
    formSheet.presentedFormSheetSize = KLNPickerViewSize;
    formSheet.shadowOpacity = 0.7;
    formSheet.shouldDismissOnBackgroundViewTap = NO;
    formSheet.shouldCenterVertically = YES;
    formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;

    __weak typeof(self) weakSelf = self;

    formSheet.willPresentCompletionHandler = ^(UIViewController *presentedFSViewController) {
        __block typeof(weakSelf) blockSelf = weakSelf;

        UINavigationController *navController = (UINavigationController *) presentedFSViewController;
        KLNPickerViewController *picker = navController.childViewControllers[0];
        picker.delegate = blockSelf;

        // Comprobamos qué celda se va a visualizar
        switch (filterCell) {
            case KLNFilterCellSort:
                [picker showPickerWithData:[KLNFactoryService arrayOfSorts] onRow:indexPath.row];
                break;
            case KLNFilterCellOrder:
                [picker showPickerWithData:[KLNFactoryService arrayOfOrder] onRow:indexPath.row];
                break;
            case KLNFilterCellMax:
            case KLNFilterCellMin:
                [picker showDatePickerOnRow:indexPath.row];
                break;
            default:
                [picker showDatePickerOnRow:indexPath.row];
                break;
        }
    };

    [self mz_presentFormSheetController:formSheet animated:YES completionHandler:nil];
}

#pragma mark - KLNPickerViewControllerDelegate

- (void)pickerView:(KLNPickerViewController *)pickerView didSelectValueOnRow:(NSInteger)row {
    // Controlamos la celda pulsada
    KLNFilterCell filterCell = (KLNFilterCell) row;

    // Comprobamos qué celda se va a visualizar
    switch (filterCell) {
        case KLNFilterCellFromDate:
            self.fromDate = pickerView.date;
            break;
        case KLNFilterCellToDate:
            self.toDate = pickerView.date;
            break;
        case KLNFilterCellSort:
            self.sort = pickerView.sort;
            [self evaluateSort];
            break;
        case KLNFilterCellMax:
            self.max = pickerView.date;
            break;
        case KLNFilterCellMin:
            self.min = pickerView.date;
            break;
        case KLNFilterCellTags:
            break;
        case KLNFilterCellOrder:
            self.order = pickerView.order;
            break;
    }

    [self.tableView reloadData];
}
- (void)pickerView:(KLNPickerViewController *)pickerView didCancel:(id)sender {
    [self.tableView reloadData];
}

@end
