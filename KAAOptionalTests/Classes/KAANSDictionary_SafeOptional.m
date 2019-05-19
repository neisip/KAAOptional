//
//  KAANSDictionary+SafeOptional.m
//  KAAOptionalTests
//
//  Created by Alex on 15/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+SafeOptional.h"

static NSDictionary<NSString *, NSString *> *KAASafeOptionalStubDict() {
    return @{ @"K": @"V"};
}

@interface KAANSDictionary_SafeOptional : XCTestCase

@end

@implementation KAANSDictionary_SafeOptional

- (void)testThat_OptionalForKey_ReturnsValueOnValuePresent {
    XCTAssertTrue([[KAASafeOptionalStubDict() kaa_optionalForKey:@"K"] isEqual:Optional.of(@"V")]);
}

- (void)testThat_OptionalForKey_ReturnsEmptyOnNoKey {
    XCTAssertTrue([[KAASafeOptionalStubDict() kaa_optionalForKey:@"O"] isEqual:Optional.empty]);
}

- (void)testThat_OptionalForKey_AssertNilKey {
    NSString *some = nil;
    XCTAssertThrows([KAASafeOptionalStubDict() kaa_optionalForKey:some]);
}

- (void)testThat_OptionalForKeyOf_ReturnsValueOnValuePresentAndRightClass {
    XCTAssertTrue([[KAASafeOptionalStubDict() kaa_optionalForKey:@"K" of:NSString.class] isEqual:Optional.of(@"V")]);
}

- (void)testThat_OptionalForKeyOf_ReturnsOptionalEmptyOnNoKey {
    XCTAssertTrue([[KAASafeOptionalStubDict() kaa_optionalForKey:@"V" of:NSString.class] isEqual:Optional.empty]);
}

- (void)testThat_OptionalForKeyOf_ReturnsOptionalEmptyOnValueNotOfClass {
    XCTAssertTrue([[KAASafeOptionalStubDict() kaa_optionalForKey:@"K" of:NSNumber.class] isEqual:Optional.empty]);
}

- (void)testThat_OptionalForKeyOf_AssertNilKey {
    NSString *some = nil;
    XCTAssertThrows([KAASafeOptionalStubDict() kaa_optionalForKey:some of:NSString.class]);
}

- (void)testThat_OptionalForKeyOf_AssertNilClass {
    Class some = nil;
    XCTAssertThrows([KAASafeOptionalStubDict() kaa_optionalForKey:@"K" of:some]);
}

- (void)testThat_FirstOptionalKeyPassingTest_ReturnOptionalWithValueOnPassedTest {
    XCTAssertTrue([[KAASafeOptionalStubDict() kaa_firstOptionalKeyPassingTest:^BOOL(NSString * _Nonnull const aKey, NSString * _Nonnull const aVal) {
        return YES;
    }] isEqual:Optional.of(@"K")]);
}

- (void)testThat_FirstOptionalKeyPassingTest_AssertsNilFilterBlock {
    id some = nil;
    XCTAssertThrows([KAASafeOptionalStubDict() kaa_firstOptionalKeyPassingTest:some]);
}
@end
