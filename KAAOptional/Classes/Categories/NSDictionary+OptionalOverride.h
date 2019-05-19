//
//  NSDictionary+OptionalOverride.h
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Optional.h"

/**
 Overrides default subscript on dictionary. But because of subscript: methods on optional - allows to chain it.
 Use if you want to force check that value in dictionary is not nil.
 
 Here is how:
 
 NSString *a = @{ @"1": @"V"} [@"2"]; <-- Will return nil and you may forget to add logic for handling it.
 
 After import of "NSDictionary+OptionalOverride.h"
 you can use op to make NSDictionary subscript return optional.
 
 NSString *e = @{ @"1" : @"V" }.op[@"2"].filter(^ (NSString *aValue) {
    return [aValue isKindOfClass:[NSString class]] && aValue.length > 1;
 }).orElse(@"Empty");
 
 Old code like that:
 
 NSInteger a = @{ @"1": @"V" }.op[@"1"].length;
 Will still compile because of message forwarding in Optional.
 
 And code like that:
 
 NSInteger a = @{ @"1" : @10 }.op[@"1"].length;
 
 Won't crash because of internal devNull forwaring logic.
 
 */
@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (OptionalOverride)

/**
 Enables return of optional on instance

 @return Same dictionary, but returns optionals on subscript.
 */
- (nonnull instancetype)op;

/**
 Will return Optional with object for Key or Optional empty if value doesn't exist.

 @param key Simple dictionary key
 @return Optional with value for key from dictionary or Optiona empty.
 */
- (nonnull Optional<ObjectType> *)objectForKeyedSubscript:(nonnull KeyType)key;

/**
 Shows if optional mode is enabled
 */
@property (nonatomic, copy, readonly, nonnull) NSNumber *kaa_shouldReturnOptional;

/**
 
 Warning! Enables optional return from dictionary for whole app!
 Old code won't crash, because of internal forwaring and won't cause bugs.
 But may cause your build fail, because of optional return.
 
 */
+ (void)kaa_enableOptionalByDefault;

@end
