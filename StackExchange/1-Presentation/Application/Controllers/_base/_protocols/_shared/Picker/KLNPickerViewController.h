//
//  KLNPickerViewController.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNBaseViewController.h"

// Protocol
@protocol KLNPickerViewControllerDelegate;

// Const
extern CGSize const KLNPickerViewSize;

@interface KLNPickerViewController : KLNBaseViewController

#pragma mark - Class methods

+ (NSString *)reuseIdentifier;

#pragma mark - Properties

@property (copy, nonatomic, readonly) NSString *sort;
@property (copy, nonatomic, readonly) NSString *order;
@property (copy, nonatomic, readonly) NSDate *date;

@property (assign, nonatomic) id <KLNPickerViewControllerDelegate> delegate;

#pragma mark - Methods

- (void)showDatePickerOnRow:(NSInteger)row;
- (void)showPickerWithData:(NSArray *)data onRow:(NSInteger)row;

@end

#pragma mark - KLNPickerViewControllerDelegate

@protocol KLNPickerViewControllerDelegate <NSObject>

- (void)pickerView:(KLNPickerViewController *)pickerView didSelectValueOnRow:(NSInteger)row;
- (void)pickerView:(KLNPickerViewController *)pickerView didCancel:(id)sender;

@end