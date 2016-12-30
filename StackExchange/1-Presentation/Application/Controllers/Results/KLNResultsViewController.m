//
//  KLNResultsViewController.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 26/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import "KLNResultsViewController.h"
#import "KLNQuestionModel.h"
#import "KLNUserModel.h"
#import "KLNResultsTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import "TOWebViewController.h"
#import "NSString+HTML.h"

@interface KLNResultsViewController ()

#pragma mark - Properties

@property(copy, nonatomic, readonly) NSArray *answeredItems;
@property(copy, nonatomic, readonly) NSArray *unansweredItems;

@end

#pragma mark -

@implementation KLNResultsViewController {
    NSArray *_answeredItems;
    NSArray *_unansweredItems;
}

#pragma mark - Properties

- (NSArray *)answeredItems {
    // Init
    if (!_answeredItems) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAnswered == YES"];
        NSArray * items = [NSArray arrayWithArray:[self.items filteredArrayUsingPredicate:predicate]];

        _answeredItems = items;
    }

    return _answeredItems;
}
- (NSArray *)unansweredItems {
    // Init
    if (!_unansweredItems) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"isAnswered == NO"];
        NSArray * items = [NSArray arrayWithArray:[self.items filteredArrayUsingPredicate:predicate]];

        _unansweredItems = items;
    }

    return _unansweredItems;
}

#pragma mark - Private methods

- (KLNQuestionModel *)questionFromSection:(NSInteger)section row:(NSInteger)row {
    NSUInteger index = (NSUInteger) row;
    return (section == 0) ? self.answeredItems[index] : self.unansweredItems[index];
}
- (UIView *)viewTableSectionWithName:(NSString *)name {
    UIView *viewTableSection = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 22.0f)];
    viewTableSection.opaque = YES;
    viewTableSection.backgroundColor = KLNStackExchange_ColorBlue;

    UILabel *sectionName = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, self.view.frame.size.width - 10.0f, 28.0f)];
    sectionName.font = [UIFont boldSystemFontOfSize:17.0f];
    sectionName.textColor = [UIColor whiteColor];
    sectionName.backgroundColor = KLNStackExchange_ColorBlue;
    sectionName.textAlignment = NSTextAlignmentCenter;
    sectionName.text = name;

    [viewTableSection addSubview:sectionName];

    return viewTableSection;
}

//- (BOOL)hasDataInSection:(NSInteger)section {
//    // No rows, exit
//    if (self.items.count == 0) {
//        return NO;
//    }
//
//    // No rows in answered section, exit
//    if (section == 0 && self.answeredItems.count == 0) {
//        return NO;
//    }
//
//    // No rows in unanswered section, exit
//    return !(section == 1 && self.unansweredItems.count == 0);
//}

#pragma mark - Livecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupController];
}

#pragma mark - KLNBaseProtocol

- (void)setupController {
    [super setupController];

    self.navigationItem.title = NSLocalizedString(@"Results", nil);
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160.0f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionName = (section == 0)
            ? NSLocalizedString(@"Answered", nil)
            : NSLocalizedString(@"Unanswered", nil);
    return [self viewTableSectionWithName:sectionName];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? self.answeredItems.count : self.unansweredItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KLNResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[KLNResultsTableViewCell reuseIdentifier]];

    if (cell == nil) {
        cell = [[KLNResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                              reuseIdentifier:[KLNResultsTableViewCell reuseIdentifier]];
    }

    KLNQuestionModel *question = [self questionFromSection:indexPath.section row:indexPath.row];

    cell.labelTitle.text = [question.title stringByConvertingHTMLToPlainText];
    cell.labelSubtitle.text = [question.owner.name stringByConvertingHTMLToPlainText];
    [cell.imageProfile setImageWithURL:question.owner.profileImage
                      placeholderImage:[KLNResultsTableViewCell imagePlaceholderWithColor:[UIColor colorWithWhite:0.902 alpha:1.000]]];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KLNQuestionModel *question = [self questionFromSection:indexPath.section row:indexPath.row];
    UINavigationController *navigationController =
            [[UINavigationController alloc] initWithRootViewController:[[TOWebViewController alloc] initWithURL:question.link]];

    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
