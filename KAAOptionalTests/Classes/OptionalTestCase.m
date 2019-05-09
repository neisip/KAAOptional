//
//  OptionalTestCase.m
//  KAAOptionalTests
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Optional.h"
#import "NSDictionary+OptionalOverride.h"

@interface OptionalTestCase : XCTestCase
@property (nonatomic, strong, nullable) Optional *sut;
@end

@implementation OptionalTestCase

- (void)testThat_It_CreatesAsEmpty {
    XCTAssert(Optional.empty != nil);
}

- (void)testThat_IsEmpty_ReturnsYesOnEmpty {
    XCTAssertTrue(Optional.empty.isEmpty);
}

- (void)testThat_IsEmpty_ReturnsNoOnHasValue {
    XCTAssertFalse(Optional.empty.hasValue);
}

#pragma mark - Get

- (void)testThat_Get_ReturnsValueIfContainerNonEmpty {
    XCTAssert([Optional of:@"S"].get != nil);
}

- (void)testThat_Get_AssertsIfContainerIsEmpty {
    XCTAssertThrows(Optional.empty.get != nil);
}

#pragma mark - Chaining

- (void)testThat_DictionaryChaining_ReturnsNotDictionary {
    NSDictionary<NSString *, NSDictionary<NSString *, NSString *> *> *sut = @{
                                                                     @"K1": @{
                                                                             @"K2": @"V"
                                                                             }
                                                                     };
    XCTAssert([sut.op[@"K1"][@"K2"].get isEqualToString:@"V"]);
}

#pragma mark - stream

- (void)testThat_Stream_ReturnsArrayWithOneElementIfOptionalHasValue {
    XCTAssert([Optional of:@"S"].stream.count == 1);
}

- (void)testThat_Stream_ReturnArrayWithZeroElementsIfOptionalIsEmpty {
    XCTAssert(Optional.empty.stream.count == 0);
}

#pragma mark - subscript

- (void)testThat_ObjectForKeyedSubscript_ReturnsOptionalWithValue {
    XCTAssert([Optional.ofNullable(@{@"Key": @"Value"})[@"Key"].get isEqualToString:@"Value"]);
}

- (void)testThat_ObjectForKeyedSubscript_ReturnsEmptyIfNotDictionary {
    XCTAssertTrue(Optional.ofNullable(@[@1])[@"K"].isEmpty);
}

- (void)testThat_ObjectAtIndexedSubscript_ReturnsOptionalWithValue {
    XCTAssertTrue([Optional.ofNullable(@[@1])[0].get isEqual:@1]);
}

- (void)testThat_ObjectAtIndexedSubscript_ReturnsEmptyIfNotArray {
    XCTAssertTrue(Optional.ofNullable(@"")[0].isEmpty);
}

#pragma mark - isEqual:

- (void)testThat_isEqual_ReturnsYesOnEqualOptionalContainers {
    id e = @{ @"Key" : Optional.ofNullable(@"123")}[@"Key"];
    XCTAssertTrue([Optional.of(@"123") isEqual:e]);
}

- (void)testThat_isEqual_ReturnsYesOnEqualOptionals {
    Optional *e = Optional.of(@"123");
    Optional *a = Optional.of(@"123");
    XCTAssertTrue([e isEqual:a]);
}

- (void)testThat_isEqual_ReturnsYesOnEmptyOptionals {
    XCTAssertTrue([Optional.empty isEqual:Optional.ofNullable(nil)]);
}

- (void)testThat_isEqual_ReturnsNoOnNotEqualOptionals {
    XCTAssertFalse([Optional.of(@"123") isEqual:Optional.of(@1)]);
}

- (void)testThat_isEqual_ReturnsNoOnRandomObject {
    XCTAssertFalse([Optional.of(@"123") isEqual:@"1"]);
}

#pragma mark - MSG send

- (void)testThat_It_dontCrashOnWrongMsgSend {
    id some = @{@"K": @"1"}.op[@"K"];
    XCTAssertNoThrow([some count]);
}

#pragma mark - NSCopying

- (void)testThat_It_copiesHashProperly {
    //given
    Optional *sut = Optional.ofNullable(@"st");
    
    //when
    id o = [sut copy];
    
    //then
    XCTAssertTrue([sut isEqual:o]);
}

@end
