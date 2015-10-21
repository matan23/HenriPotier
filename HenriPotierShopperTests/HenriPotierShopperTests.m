//
//  HenriPotierShopperTests.m
//  HenriPotierShopperTests
//
//  Created by Mathieu Tan on 10/21/15.
//  Copyright © 2015 Mathieu Tan. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "MTJSocketStore.h"
#import "PotierClient.h"

#import "Book.h"

@interface HenriPotierShopperTests : XCTestCase {
    MTJSocketStore *_store;
}

@end

@implementation HenriPotierShopperTests

- (void)setUp {
    [super setUp];

    _store = [MTJSocketStore sharedStore];
    _store.client = [PotierClient clientWithAppID:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSyncingBooksShouldSucceed {
    XCTestExpectation *expectation = [self expectationWithDescription:@"networkCallExpectation"];
    
    [_store syncCollectionOfType:(id<MTJSyncedEntity>)[Book class] completion:^(NSArray *collection, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(collection);
        
        [expectation fulfill];
    }];
    
    [self asyncWait];
}

- (void)asyncWait {
    [self waitForExpectationsWithTimeout:100.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}


@end
