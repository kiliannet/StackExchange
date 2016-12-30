//
//  KLNQuestionServiceTests.m
//  StackExchange
//
//  Created by Eduardo Palenzuela Darias on 25/9/15.
//  Copyright © 2015 Eduardo Palenzuela Darias. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KLNFactoryService.h"
#import "KLNResultModel.h"

@interface KLNQuestionServiceTests : XCTestCase

@end

@implementation KLNQuestionServiceTests

#pragma mark - Livecycle

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Tests

/**
 *  Gets all the questions on the site.
 */
- (void)testGetAllQuestions {
    //Expectation
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing: KLNQuestionService | Method: questionBySite"];
    
    id <KLNQuestionServiceProtocol> service = [KLNFactoryService serviceConformToProtocol:@protocol(KLNQuestionServiceProtocol)];
    
    [service questionBySite:[KLNFactoryService stringOfDefaultSiteName]
                   fromDate:nil
                     toDate:nil
                      order:[KLNFactoryService arrayOfOrder][0]
                        min:nil
                        max:nil
                       sort:[KLNFactoryService arrayOfSorts][0]
                     tagged:nil
                       page:@(KLNServicePage)
                   pageSize:@(KLNServicePageSize)
                   callback:^(KLNResultModel *item, NSError *error) {
                       // Check error
                       if (error) {
                           NSLog(@"error is: %@", error);
                       } else {
                           XCTAssertGreaterThan([item.items count], 0);
                           [expectation fulfill];
                       }
                   }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            XCTFail(@"Expectation failed with error: %@", error);
        }
    }];
}

@end
