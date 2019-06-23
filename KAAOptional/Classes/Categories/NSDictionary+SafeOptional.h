//
//  NSDictionary+SafeOptional.h
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


@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (SafeOptional)

/**
 Wraps dictionary in optional. You can still use subscripts the old way, but returned values will be optional!
 
 @return Optional with this dictionary.
 */
- (nonnull Optional<NSDictionary<KeyType, ObjectType> *> *)op;


- (nonnull Optional<ObjectType> *)kaa_optionalForKey:(nonnull KeyType)aKey __attribute__((pure));
- (nonnull Optional<ObjectType> *)kaa_optionalForKey:(nonnull KeyType)aKey of:(nonnull Class)aClass __attribute__((pure));
- (nonnull Optional<ObjectType> *)kaa_firstOptionalKeyPassingTest:(NS_NOESCAPE BOOL (^_Nonnull const)(const KeyType _Nonnull aKey, const ObjectType _Nonnull aVal))testBlock __attribute__((pure));
@end
