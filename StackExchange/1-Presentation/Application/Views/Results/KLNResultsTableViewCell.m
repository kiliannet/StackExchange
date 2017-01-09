//
//  KLNResultsTableViewCell.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 26/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNResultsTableViewCell.h"

static const CGFloat KLNResultsCellProfileSize = 44.0f;

@implementation KLNResultsTableViewCell

#pragma mark - Class methods

+ (NSString *)reuseIdentifier {
    static NSString *reuseIdentifier = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reuseIdentifier = NSStringFromClass([KLNResultsTableViewCell class]);
    });

    return reuseIdentifier;
}
+ (UIImage *)imagePlaceholderWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, KLNResultsCellProfileSize, KLNResultsCellProfileSize);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

#pragma mark - Lifecycle

- (void)layoutSubviews {
    [super layoutSubviews];

    self.imageProfile.layer.masksToBounds = YES;
    self.imageProfile.layer.cornerRadius = KLNResultsCellProfileSize / 2;
    self.labelSubtitle.textColor = KLNStackExchange_ColorLightBlue;
}

@end
