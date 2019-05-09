//
//  KAANSDictionary_OptionalOverrideTestCase.m
//  KAAOptionalTests
//
//  Created by Alex on 15/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Optional.h"
#import "NSDictionary+OptionalOverride.h"

@interface KAANSDictionary_OptionalOverrideTestCase : XCTestCase

@end

@implementation KAANSDictionary_OptionalOverrideTestCase

- (void)testThat_ObjectForKeyedSubscript_ReturnsOptionalWithValue {
    //given
    NSDictionary *di = @{ @"K1": @"V" };
    //when
    Optional *o = di.op[@"K1"];
    //then
    XCTAssertTrue([o isEqual:Optional.of(@"V")]);
}

- (void)testThat_ObjectForKeyedSubscript_ReturnsEmptyOptionalWithNoValue {
    XCTAssertTrue([@{@"Key1": @"Value"}.op[@"K"] isEqual:Optional.empty]);
}

- (void)testThat_ObjectForKeyedSubscript_HandlesRandomMessage {
    id some = @{@"Key1" : @"Value"}[@"K"];
    XCTAssertNoThrow([some count]);
}

@end
