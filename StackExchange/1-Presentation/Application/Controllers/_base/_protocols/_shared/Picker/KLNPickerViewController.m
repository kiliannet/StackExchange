//
//  KLNPickerViewController.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNPickerViewController.h"
#import "MZFormSheetController.h"

CGSize const KLNPickerViewSize = {310.0f, 350.0f};

@interface KLNPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
@private
    NSInteger _rowSelected;
}

#pragma mark - Properties

@property (copy, nonatomic, readonly) UIBarButtonItem *buttonClose;
@property (copy, nonatomic, readonly) UIBarButtonItem *buttonDone;
@property (copy, nonatomic, readonly) UIPickerView *picker;
@property (copy, nonatomic, readonly) UIDatePicker *datePicker;

@property (assign, nonatomic, readonly) CGRect rect;

@property (assign, nonatomic) NSInteger row;
@property (copy, nonatomic) NSArray *data;

@end

#pragma mark -

@implementation KLNPickerViewController {
    UIBarButtonItem *_buttonClose;
    UIBarButtonItem *_buttonDone;
    UIPickerView *_picker;
    UIDatePicker *_datePicker;
}

#pragma mark - Class methods

+ (NSString *)reuseIdentifier {
    static NSString *reuseIdentifier = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reuseIdentifier = NSStringFromClass([KLNPickerViewController class]);
    });

    return reuseIdentifier;
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
- (UIBarButtonItem *)buttonDone {
    // Init
    if (!_buttonDone) {
        UIImage * imageButtonItem = [IonIcons imageWithIcon:ion_ios_checkmark_outline
                                                       size:KLNStackExchange_BarButtonIconSize
                                                      color:KLNStackExchange_ColorBlue];
        UIBarButtonItem *buttonItem = [KLNUtils barButtonItemWithImage:imageButtonItem
                                                                target:self
                                                                action:@selector(buttonDoneTapped:)];
        _buttonDone = buttonItem;
    }

    return _buttonDone;
}
- (UIPickerView *)picker {
    // Init
    if (!_picker) {
        UIPickerView *localPicker = [[UIPickerView alloc] initWithFrame:self.rect];
        localPicker.dataSource = self;
        localPicker.delegate = self;

        _picker = localPicker;
    }

    return _picker;
}
- (UIDatePicker *)datePicker {
    // Init
    if (!_datePicker) {
        UIDatePicker *localPicker = [[UIDatePicker alloc] initWithFrame:self.rect];
        localPicker.datePickerMode = UIDatePickerModeDate;
        localPicker.date = [NSDate date];

        _datePicker = localPicker;
    }

    return _datePicker;
}

- (CGRect)rect {
    CGFloat y = self.navigationController.navigationBar.frame.size.height / 2.0f;
    return CGRectMake(0.0f, (0.0f - y), KLNPickerViewSize.width, KLNPickerViewSize.height);
}

- (NSString *)order {
    return self.data[(NSUInteger) _rowSelected];
}
- (NSString *)sort {
    return self.data[(NSUInteger) _rowSelected];
}
- (NSDate *)date {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnit) flags fromDate:self.datePicker.date];
    [components setHour:00];
    [components setMinute:00];
    [components setSecond:00];
    [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];

    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

#pragma mark - Methods

- (void)showDatePickerOnRow:(NSInteger)row {
    [self.view addSubview:self.datePicker];
    self.row = row;
}
- (void)showPickerWithData:(NSArray *)data onRow:(NSInteger)row {
    [self.view addSubview:self.picker];
    self.data = data;
    self.row = row;
}

#pragma mark - Private methods

- (void)buttonCloseTapped:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
    [self.delegate pickerView:self didCancel:sender];
}
- (void)buttonDoneTapped:(id)sender {
    [self mz_dismissFormSheetControllerAnimated:YES completionHandler:nil];
    [self.delegate pickerView:self didSelectValueOnRow:self.row];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _rowSelected = 0;

    [self setupController];
}

#pragma mark - KLNBaseProtocol

- (void)setupController {
    [super setupController];

    self.navigationItem.title = NSLocalizedString(@"Select", nil);
    self.navigationItem.leftBarButtonItem = self.buttonClose;
    self.navigationItem.rightBarButtonItem = self.buttonDone;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if ([pickerView isEqual:self.picker]) {
        return 1;
    }

    return 0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.picker]) {
        return self.data.count;
    }

    return 0;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.picker]) {
        return self.data[(NSUInteger) row];
    }

    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual:self.picker]) {
        _rowSelected = row;
    }
}

@end
