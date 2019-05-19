//
//  AppDelegate.m
//  KAAOptional-Example
//
//  Created by Alex on 15/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "AppDelegate.h"

@import KAAOptional;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self createOptional];
    [self protectFromForgettingToCheckForNilFromMethod];
    [self dictionaryParsing];
    [self automaticControlFlow];
    return YES;
}

- (void)createOptional {
    __unused __auto_type a = Optional.empty; // Has nil value
    __unused __auto_type b1 = Optional.of(@1); // Has 1 value, and will assert if nil;
    __unused __auto_type b2 = [Optional of:@1]; // Another way to create 1, but by keeping it generic safe;
    __unused __auto_type ob1 = Optional.ofNullable(@1); //Has 1 value;
    __unused __auto_type ob2 = Optional.ofNullable(nil); //Has nil value;
    __unused __auto_type ob1_2 = [Optional ofNullable:@1];
    __unused __auto_type ob1_3 = [Optional ofNullable:nil];
    
    __unused __auto_type obc = [Optional of:@1 as:NSNumber.class]; // Optional with 1 - it asserts if it's nil or not Number;
    __unused __auto_type obc2 = Optional.ofNullableAs(nil, NSString.class); //Returns Optional.empty;
}

- (void)protectFromForgettingToCheckForNilFromMethod {
    __unused __auto_type a = [[[[self fetchResult] filter:^BOOL(NSString * _Nonnull aValue) {
        return aValue.integerValue > 123 && [aValue isKindOfClass:[NSString class]];
    }] /* Returns Optional.empty */ orVal:^Optional<NSString *> *{
        return Optional.of(@404);
    }] /* Returns Optional with 404 */stream]; /*Returns Array with 404 */
    
    //or .dot notation, thought not so good with type inference and autocompletion : (
    
    __unused __auto_type b = [self fetchResult]
    .filter(^BOOL(NSString * _Nonnull aValue) {
        return aValue.integerValue > 123 && [aValue isKindOfClass:[NSString class]];
    }).orVal(^Optional<NSString *> *{
        return Optional.of(@404);
    }).stream;
}

- (nonnull Optional<NSString *> *)fetchResult {
    //Some big work;
    return Optional.of(@"123");
}

- (void)dictionaryParsing {
    __auto_type a = @{
                      @"K": @[@{@"K2": @"V"}]
                      };
    //By using subscript, you get optional! An it can be chained!
    __unused NSString *b = a[@"K"][0][@"K2"].orElse(@"V2");
}

- (void)automaticControlFlow {
    @{@"K":@"V"}[@"K2"].ifPresentOrElse(^(id  _Nonnull aValue) {
        NSLog(@"It has value! %@", aValue);
    }, ^{
        NSLog(@"No value");
    });
}

@end
