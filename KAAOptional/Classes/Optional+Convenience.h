//
//  Optional+Convenience.h
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 All of the lower is just a sugar on top of Generic cathegory.
 */
@interface Optional<SomeType> (Convenience)

/**
 Same as +of: method.
 */

@property (nonatomic, copy, readonly, class, nonnull) Optional<SomeType> *(^of)(SomeType _Nonnull aValue);

/**
 Same as +of:as: method.
 */
@property (nonatomic, copy, readonly, class, nonnull) Optional<SomeType> *(^ofValueAs)(SomeType _Nonnull aValue, Class _Nonnull klass);

/**
 Same as +ofNullable: method.
 */
@property (nonatomic, copy, readonly, class, nonnull) Optional<SomeType> *(^ofNullable)(SomeType _Nullable aValue);

/**
 Same as +ofNullable:as: method.
 */
@property (nonatomic, copy, readonly, class, nonnull) Optional<SomeType> *(^ofNullableAs)(SomeType _Nullable aValue, Class _Nonnull klass);

/**
 If value is present, returns an Optional describing the value, otherwise returns an Optional produced by the supplying function.
 */
@property (nonatomic, copy, readonly, nonnull) Optional *(^orVal)(NS_NOESCAPE Optional *(^_Nonnull const orAction)(void));

/**
 If a value is present, returns the value, otherwise returns other.
 */
@property (nonatomic, copy, readonly, nonnull) id (^orElse)(SomeType _Nonnull const);

/**
 If a value is present, returns the value, otherwise returns the result produced by the supplying function
 */
@property (nonatomic, copy, readonly, nonnull) id (^orElseGet)(NS_NOESCAPE id (^_Nonnull const orElseGetAction)(void));


/**
 If a value is present, returns an Optional describing (as if ofNullable(T)) the result of applying the given mapping functions to the value, otherwise returns an Optional.empty.
 If the mapping function returns a null result then this method returns an Optional.empty
 */
@property (nonatomic, copy, readonly, nonnull) Optional *(^map)(NS_NOESCAPE id (^_Nonnull const mapAction)(id _Nonnull aValue));

/**
 If a value is present, returns the result of applying the given Optional-bearing mapping function to the value, otherwise returns an empty Optional.
 */
@property (nonatomic, copy, readonly, nonnull) Optional *(^flatMap)(NS_NOESCAPE Optional *(^_Nonnull const aFlatMapAction)(id _Nonnull aValue));

/**
 If a value is present and the value matched the given predicate, returns an Optional describing the value, otherwise returns an empty Optional.
 */
@property (nonatomic, copy, readonly, nonnull) Optional *(^filter)(NS_NOESCAPE BOOL (^_Nonnull const aFilterAction)(id aValue));

/**
 If a value is present, performs the given action with the value, otherwise does nothing.
 */
@property (nonatomic, copy, readonly, nonnull) void (^ifPresent)(NS_NOESCAPE void (^_Nonnull const aPresentAction)(id _Nonnull aValue));

/**
  If a value is present, performs the given action with the value, otherwise performs the given empty-based action.
 */
@property (nonatomic, copy, readonly, nonnull) void (^ifPresentOrElse)(NS_NOESCAPE void (^_Nullable const aPresentAction)(id _Nonnull aValue), NS_NOESCAPE dispatch_block_t _Nullable orElse);



@end
