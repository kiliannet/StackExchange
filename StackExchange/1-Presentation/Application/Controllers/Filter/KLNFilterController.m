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

@interface KLNFilterController () <KLNPickerViewControllerDelegate> {
@private
    NSDate *_fromDate;
    NSDate *_toDate;
    NSString *_sort;
    id _max;
    id _min;
    NSString *_tags;
    NSString *_order;
    id <KLNQuestionServiceProtocol> _service;
}

#pragma mark - Properties

@property(copy, nonatomic, readonly) UIBarButtonItem *buttonAcknowledgements;
@property(copy, nonatomic, readonly) UIBarButtonItem *buttonRefresh;
@property(copy, nonatomic, readonly) UIBarButtonItem *buttonLoading;
@property(copy, nonatomic, readonly) UIRefreshControl *refresh;

@property(assign, nonatomic, readonly) BOOL isNotAcceptedMaxOrMin;

@end

#pragma mark -

@implementation KLNFilterController {
    UIBarButtonItem *_buttonAcknowledgements;
    UIBarButtonItem *_buttonRefresh;
    UIBarButtonItem *_buttonLoading;
    UIRefreshControl *_refresh;
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
    return ([_sort isEqualToString:@"hot"] || [_sort isEqualToString:@"week"] || [_sort isEqualToString:@"month"]);
}

#pragma mark - Private methods

- (void)setDefaultValues {
    _fromDate = nil;
    _toDate = nil;
    _sort = [KLNFactoryService arrayOfSorts][0];
    _max = nil;
    _min = nil;
    _tags = nil;
    _order = [KLNFactoryService arrayOfOrder][0];
    
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
            _max = alert.textFields[0].text;
        } else {
            _min = alert.textFields[0].text;
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
        _tags = (value.length > 0) ? value : nil;
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
    if (_min) {
        min = [_min isKindOfClass:[NSDate class]]
        ? @((long) [_min timeIntervalSince1970])
        : @([_min integerValue]);
    }
    
    // Prepare max
    NSNumber * max;
    if (_max) {
        max = [_max isKindOfClass:[NSDate class]]
        ? @((long) [_max timeIntervalSince1970])
        : @([_max integerValue]);
    }
    
    __weak typeof(self) weakSelf = self;
    
    [_service questionBySite:[KLNFactoryService stringOfDefaultSiteName]
                    fromDate:_fromDate == nil ? nil : @((long) [_fromDate timeIntervalSince1970])
                      toDate:_toDate == nil ? nil : @((long) [_toDate timeIntervalSince1970])
                       order:_order
                         min:min
                         max:max
                        sort:_sort
                      tagged:_tags == nil ? nil : [_tags componentsSeparatedByString:@" "]
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
    if ([_sort isEqualToString:@"votes"] && ([_min isKindOfClass:[NSDate class]] || [_max isKindOfClass:[NSDate class]])) {
        _min = nil;
        _max = nil;
        
        return;
    }
    
    if (self.isNotAcceptedMaxOrMin) {
        _min = nil;
        _max = nil;
        
        return;
    }
    
    if (![_min isKindOfClass:[NSDate class]] || ![_max isKindOfClass:[NSDate class]]) {
        _min = nil;
        _max = nil;
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

    _service = [KLNFactoryService serviceConformToProtocol:@protocol(KLNQuestionServiceProtocol)];
    
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
            cell.detailTextLabel.text = (_fromDate == nil) ? @"" : [[KLNUtils dateFormatter] stringFromDate:_fromDate];
            iconName = ion_ios_calendar_outline;
            break;
        case KLNFilterCellToDate:
            cell.textLabel.text = NSLocalizedString(@"To date", nil);
            cell.detailTextLabel.text = (_toDate == nil) ? @"" : [[KLNUtils dateFormatter] stringFromDate:_toDate];
            iconName = ion_ios_calendar_outline;
            break;
        case KLNFilterCellSort:
            cell.textLabel.text = NSLocalizedString(@"Sort", nil);
            cell.detailTextLabel.text = (_sort == nil) ? @"" : _sort;
            iconName = ion_arrow_swap;
            break;
        case KLNFilterCellMax:
            cell.textLabel.text = NSLocalizedString(@"Max", nil);
            cell.detailTextLabel.text = [_max isKindOfClass:[NSDate class]] ? [[KLNUtils dateFormatter] stringFromDate:_max] : _max;
            iconName = ion_ios_plus_empty;
            break;
        case KLNFilterCellMin:
            cell.textLabel.text = NSLocalizedString(@"Min", nil);
            cell.detailTextLabel.text = [_min isKindOfClass:[NSDate class]] ? [[KLNUtils dateFormatter] stringFromDate:_min] : _min;
            iconName = ion_ios_minus_empty;
            break;
        case KLNFilterCellTags:
            cell.textLabel.text = NSLocalizedString(@"Tags", nil);
            cell.detailTextLabel.text = (_tags == nil) ? @"" : _tags;
            iconName = ion_ios_pricetags_outline;
            break;
        case KLNFilterCellOrder:
            cell.textLabel.text = NSLocalizedString(@"Order", nil);
            cell.detailTextLabel.text = (_order == nil) ? @"" : _order;
            iconName = [_order isEqualToString:@"asc"] ? ion_arrow_up_b : ion_arrow_down_b;
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

    if ([_sort isEqualToString:@"votes"] && isMaxOrMinCell) {
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
            _fromDate = pickerView.date;
            break;
        case KLNFilterCellToDate:
            _toDate = pickerView.date;
            break;
        case KLNFilterCellSort:
            _sort = pickerView.sort;
            [self evaluateSort];
            break;
        case KLNFilterCellMax:
            _max = pickerView.date;
            break;
        case KLNFilterCellMin:
            _min = pickerView.date;
            break;
        case KLNFilterCellTags:
            break;
        case KLNFilterCellOrder:
            _order = pickerView.order;
            break;
    }

    [self.tableView reloadData];
}
- (void)pickerView:(KLNPickerViewController *)pickerView didCancel:(id)sender {
    [self.tableView reloadData];
}

@end
