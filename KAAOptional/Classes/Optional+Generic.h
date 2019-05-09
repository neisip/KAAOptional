//
//  Optional+Generic.h
//  KAAOptional
//
//  Created by Alex on 13/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//
#import <Foundation/Foundation.h>


/**
 Syntax is taken from Java optionals
 */
@interface Optional<SomeType> (Generic)

/**
 If a value is present, returns an Optional describing the value, otherwise returns an Optional produced by the function.

 @param orValSupplier Block which returns Optional with value in case of nil
 @return Optional with nonnull value or Optional from supplier block
 */

- (nonnull Optional<SomeType> *)orVal:(NS_NOESCAPE Optional<SomeType> *(^_Nonnull const)(void))orValSupplier;

/**
 If a value is present, returns the value, otherwise returns other.

 @param elseVal Value which will be used in case of nil value
 @return Contained value if it isn't nil or elseVal
 */
- (SomeType _Nonnull)orElse:(SomeType _Nonnull const)elseVal;

/**
 If a value is present, returns the value, otherwise returns the result produced by the supplying function

 @param elseValSupplier Block which returns value in case of nil
 @return Contained value if it isn't nil or value passed by supply block
 */
- (SomeType _Nonnull)orElseGet:(NS_NOESCAPE SomeType (^_Nonnull const)(void))elseValSupplier;

/**
 If a value is present, returns an Optional describing (as if by ofNullable:) the result of applying the given function to the value, otherwise returns an empty Optional.
 If the mapping function returns a null result then this method

 @param aMapAction action which returns mapped value
 @return Optional describing (as if by ofNullable:) the result of applying map function
 */
- (nonnull Optional *)map:(NS_NOESCAPE id (^_Nonnull const)(SomeType _Nonnull aValue))aMapAction;

/**
 If a value is present, returns the result of applying the given Optional-bearing mapping function to the value, otherwise returns an empty Optional

 @param aFlatMapAction action which should return mapped value contained in Optional
 @return If a value is present, returns the result of applying the given Optional-bearing mapping the function to the value, otherwise returns an empty Optional
 */
- (nonnull Optional *)flatMap:(NS_NOESCAPE Optional *(^_Nonnull const)(SomeType _Nonnull aValue))aFlatMapAction;

/**
 If a value is present, and it matches the given predicate, returns an Optional describing the value, otherwise returns an empty Optional

 @param aFilterAction Predicate action which determines if Optional with value should be returned or empty.
 @return Optional with value if aFilterAction returns YES or Optional.empty otherwise.
 */
- (nonnull Optional<SomeType> *)filter:(NS_NOESCAPE BOOL (^_Nonnull const)(SomeType _Nonnull aValue))aFilterAction;

/**
 If a value is present, performs the given action with the value, otherwise does nothing.

 @param anIfPresentAction Action which performs if value isPresent
 */
- (void)ifPresent:(NS_NOESCAPE void (^_Nonnull const)(SomeType _Nonnull aValue))anIfPresentAction;

/**
  If a value is present, performs the given action with the value, otherwise performs empty action.

 @param anIfPresentAction Action which performs if value isPresent
 @param orElseAction Action which performs if value isEmpty
 */
- (void)ifPresent:(NS_NOESCAPE void (^_Nonnull const)(SomeType _Nonnull aValue))anIfPresentAction orElse:(nullable NS_NOESCAPE dispatch_block_t)orElseAction;

@end

