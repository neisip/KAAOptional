//
//  Optional+ConvenienceTestCase.m
//  KAAOptionalTests
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Optional.h"


static NSNumber *kOptionalGenericStubNumber() {
    return @123;
}

@interface Optional_ConvenienceTestCase : XCTestCase

@end

@implementation Optional_ConvenienceTestCase

- (void)testThat_Of_CreatesWithNonEmptyValue {
    XCTAssert(Optional.of(@"") != nil);
}

- (void)testThat_Of_AssertsEmptyValue {
    id some = nil;
    XCTAssertThrows(Optional.of(some));
}

- (void)testThat_OfAs_CreatesWith_ProperClassAndNonnullValue {
    XCTAssert(Optional.ofValueAs(@"NSString" , [NSString class]) != nil);
}

- (void)testThat_OfAs_Throws_WithEmptyValue {
    id some = nil;
    XCTAssertThrows(Optional.ofValueAs(some, [NSString class]));
}

- (void)testThat_OfAs_Throws_WithEmptyClass {
    Class some = nil;
    XCTAssertThrows(Optional.ofValueAs(@"S", some));
}

- (void)testThat_OfAs_Throws_WithValueOfWrongClass {
    XCTAssertThrows(Optional.ofValueAs(@"s", [NSNumber class]));
}

#pragma mark - ofNullable

- (void)testThat_OfNullable_CreatesOptionalWithValue {
    XCTAssert(Optional.ofNullable(@"") != nil);
}

- (void)testThat_OfNullable_CreatesEmptyOptional {
    XCTAssert(Optional.ofNullable(nil).isEmpty);
}

- (void)testThat_OfNullableAs_CreatesValueOptionalWithRightClassAndValue {
    XCTAssertTrue(Optional.ofNullableAs(@"N", NSString.class).hasValue);
}

- (void)testThat_OfNullableAs_CreatesEmptyOptional_OnNilValue {
    XCTAssertTrue(Optional.ofNullableAs(nil, NSString.class).isEmpty);
}

- (void)testThat_OfNullableAs_AssertsNilClass {
    Class s = nil;
    XCTAssertThrows(Optional.ofNullableAs(@"s",s).isEmpty);
}

- (void)testThat_OfNullableAs_ReturnsEmptyIfValueIsNotOfGivenClass {
    XCTAssertTrue(Optional.ofNullableAs(@"s" , NSNumber.class).isEmpty);
}

#pragma mark - OrVal:

- (void)testThat_OrVal_ReturnsOptionalWithValue {
    XCTAssert(Optional.of(@"").orVal([self orValBlock]).get != nil);
}

- (Optional *(^const)(void))orValBlock {
    return ^ {
        return Optional.of(kOptionalGenericStubNumber());
    };
}

- (void)testThat_OrVal_AssertNilOrBlock {
    id some = nil;
    XCTAssertThrows(Optional.empty.orVal(some));
}

- (void)testThat_OrVal_ReturnValueFromSupplierBlock {
    XCTAssert([Optional.empty.orVal([self orValBlock]).get isEqualToNumber:kOptionalGenericStubNumber()]);
}

#pragma mark - OrElse:

- (void)testThat_OrElse_ReturnsOptionalWithValue {
    XCTAssert([Optional.of(@"").orElse(kOptionalGenericStubNumber()) isEqualToString:@""]);
}

- (void)testThat_OrElse_ReturnElseWithNoValue {
    XCTAssert([Optional.empty.orElse(kOptionalGenericStubNumber()) isEqualToNumber:kOptionalGenericStubNumber()]);
}

- (void)testThat_OrElse_AssertEmptyElse {
    id some = nil;
    XCTAssertThrows(Optional.empty.orElse(some));
}

#pragma mark - OrElseGet:

- (void)testThat_OrElseGet_ReturnsOptionalWithValue {
    XCTAssert([Optional.of(@"").orElseGet([self orElseGetBlock]) isEqualToString:@""]);
}

- (id (^const)(void))orElseGetBlock {
    return ^ {
        return kOptionalGenericStubNumber();
    };
}

- (void)testThat_OrElseGet_ReturnsElseWithNoValue {
    XCTAssert([Optional.empty.orElseGet([self orElseGetBlock]) isEqualToNumber:kOptionalGenericStubNumber()]);
}

- (void)testThat_OrElseGet_AssertEmptyElse {
    id some = nil;
    XCTAssertThrows(Optional.empty.orElseGet(some));
}

#pragma mark - map:

- (void)testThat_Map_ReturnsOptionalWithMappedValue {
    //given
    Optional<NSString *> *sut = Optional.of(kOptionalGenericStubNumber().stringValue);
    Optional *comr = Optional.of(kOptionalGenericStubNumber());
    
    //when
    Optional *r = sut.map([self mapBlock]);

    //then
    XCTAssertTrue([r isEqual:comr]);
}

- (id (^const)(id _Nonnull))mapBlock {
    return ^(NSString *_Nonnull aValue) {
        return @(aValue.integerValue);
    };
}

- (void)testThat_Map_ReturnsEmptyOptionalWithNoValue {
    //given
    Optional *sut = Optional.empty;
    
    //when
    Optional *r = sut.map([self mapBlock]);
    
    //then
    XCTAssertThrows(r.get);
}

- (void)testThat_Map_AssertsNilBlock {
    id some = nil;
    XCTAssertThrows(Optional.empty.map(some));
}

#pragma mark - flatMap:

- (void)testThat_FlatMap_ReturnOptionalFromFlatMapBlock {
    //given
    Optional<NSString *> *sut = Optional.of(kOptionalGenericStubNumber().stringValue);
    Optional *comr = Optional.of(kOptionalGenericStubNumber());
    
    //when
    Optional *r = sut.flatMap([self flatMapBlock]);
    
    //then
    XCTAssertTrue([r isEqual:comr]);
}

- (Optional *(^const)(id _Nonnull))flatMapBlock {
    return ^Optional *(NSString *_Nonnull aValue) {
        return Optional.of(@(aValue.integerValue));
    };
}

- (void)testThat_FlatMap_ReturnsEmptyWithNoValue {
    //given
    Optional *sut = Optional.empty;
    //when
    Optional *r = sut.flatMap([self flatMapBlock]);
    //then
    XCTAssertThrows(r.get);
}

- (void)testThat_FlatMap_AssertsNilBlock {
    id some = nil;
    XCTAssertThrows(Optional.empty.flatMap(some));
}

- (void)testThat_FlatMap_AssertsNonOptionalOnReturn {
    XCTAssertThrows(Optional.of(@123).flatMap(^Optional *(id _Nonnull aValue) {
        Optional *e = nil;
        return e;
    }));
}

#pragma mark - filter:

- (void)testThat_Filter_ReturnsOptionalWithValue_IfItPassesTest {
    XCTAssert([Optional.of(@"123").filter([self filterBlock]).get isEqualToString:@"123"]);
}

- (BOOL (^)(id aValue))filterBlock {
    return ^BOOL (id _Nonnull aValue) {
        return [aValue length] == 3;
    };
}

- (void)testThat_Filter_ReturnsEmpty_IfItDoesntPassTest {
    XCTAssertThrows(Optional.of(@"").filter([self filterBlock]).get);
}

- (void)testThat_Filter_AssertsEmptyBlock {
    id some = nil;
    XCTAssertThrows(Optional.of(@"").filter(some).get);
}

#pragma mark - ifPresent:

- (void)testThat_IfPresent_ExecutesBlockWithValue {
    //given
    Optional *sut = Optional.of(@"123");
    __block BOOL hasExecuted = NO;
    
    //when
    sut.ifPresent(^(id  _Nonnull aValue) {
        hasExecuted = YES;
    });
    
    //then
    XCTAssertTrue(hasExecuted);
}

#pragma mark - ifPresent:orElse

- (void)testThat_IfPresentOrElse_ExecutesBlockWithValue {
    //given
    Optional *sut = Optional.of(@"123");
    __block BOOL hasExecuted = NO;
    id some = nil;
    //when
    sut.ifPresentOrElse(^(id  _Nonnull aValue) {
        hasExecuted = YES;
    }, some);
    
    //then
    XCTAssertTrue(hasExecuted);
}

- (void)testThat_ifPresentOrElse_ExecutesElseBlockWithEmptyValue {
    //given
    __block BOOL hasExecuted = NO;
    
    //when
    Optional.empty.ifPresentOrElse(nil, ^{
        hasExecuted = YES;
    });
    
    //then
    XCTAssertTrue(hasExecuted);
}
@end

