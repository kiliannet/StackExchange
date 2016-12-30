//
//  KLNResultsTableViewCell.h
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 26/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLNResultsTableViewCell : UITableViewCell

#pragma mark - Class methods

+ (NSString *)reuseIdentifier;
+ (UIImage *)imagePlaceholderWithColor:(UIColor *)color;

#pragma mark - IBOutlets

@property(weak, nonatomic) IBOutlet UILabel *labelTitle;
@property(weak, nonatomic) IBOutlet UILabel *labelSubtitle;
@property(weak, nonatomic) IBOutlet UIImageView *imageProfile;

@end
