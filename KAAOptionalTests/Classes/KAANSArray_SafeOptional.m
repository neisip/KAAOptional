//
//  KAANSArray_SafeOptional.m
//  KAAOptionalTests
//
//  Created by Alex on 15/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+SafeOptional.h"

@interface KAANSArray_SafeOptional : XCTestCase

@end

@implementation KAANSArray_SafeOptional

- (void)testThat_It_ReturnOptionalWithValueWhenFound {
    //given
    NSArray *a = @[@1, @2];
    
    //when
    Optional<NSNumber *> *b = [a kaa_firstOptionalObjectPassingTest:^BOOL(NSNumber * _Nonnull const aVal) {
        return aVal.integerValue == 2;
    }];
    //then
    XCTAssertTrue([b.get isEqualToNumber:@(2)]);
}

- (void)testThat_It_AssertsNilBlock {
    id some = nil;
    XCTAssertThrows([@[] kaa_firstOptionalObjectPassingTest:some]);
}

- (void)testThat_It_ReturnOptionalEmptyWhenObjectNotFound {
    //given
    NSArray<NSNumber *> *a = @[@1, @2];
    
    //when
    Optional<NSNumber *> *b = [a kaa_firstOptionalObjectPassingTest:^BOOL(NSNumber * _Nonnull const aVal) {
        return aVal.integerValue == 3;
    }];
    //then
    XCTAssertTrue([b isEqual:Optional.empty]);
}
@end
