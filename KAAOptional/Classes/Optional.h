//
//  Optional.h
//  KAAOptional
//
//  Created by Alex on 13/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KAA_FINAL __attribute__((objc_subclassing_restricted))

#define KAA_ASSERT_AND_RETURN_OPTIONAL(condition) if(!(condition)) { \
NSParameterAssert(condition); \
return Optional.empty; \
}


// Note 1: Breaks naming notation and ISP for sake of use convenience.
// Note 2: ObjC lightweight generics aren't fully supported in typedefs and derived parameters in Blocks. That's why we have 2 apis 1) - methods with full generics support 2) convenience blocks which call these methods.

KAA_FINAL
@interface Optional<SomeType> : NSObject <NSCopying>
/**
 Checks if no value
 */
@property (nonatomic, readonly) BOOL isEmpty;

/**
 Checks if has value
 */
@property (nonatomic, readonly) BOOL hasValue;

/**
    Extracts data from optional. Will assert if it's nil!
    Get methods is taken from Java 8 for easier adaptation.
 */
@property (nonatomic, readonly, nonnull) SomeType get;

/**
 If value is present, returns an array containing only that value, otherwise returns
 an empty array
 */
@property (nonatomic, copy, readonly, nonnull) NSArray<SomeType> *list;

/**
 Returns empty optional

 @return Optional.empty
 */
+ (nonnull instancetype)empty;

/**
 Creates optional with value and asserts if it's nil
 
 @param aValue : nonnull value - or assert
 @return guaranteed nonnull optional
 */

+ (nonnull instancetype)of:(nonnull SomeType const)aValue;

/**
 Creates optional with value and class. Asserts if value doesn't conform to class.
 
 @param aValue : nonnull value - or assert
 @return guaranteed nonnull optional
 */

+ (nonnull instancetype)of:(nonnull SomeType const)aValue as:(nonnull Class)aClass;

/**
 Creates optional all allows passing nil as value

 @param aValue :some nullable value
 @return if value is present return Optional with it. Otherwise it returns Optional.empty
 */

+ (nonnull instancetype)ofNullable:(nullable SomeType const)aValue;

/**
 Creates optional with value and class of this value. If value is nil or it doesn't conform to class it return Optional.empty

 @param aValue :some nullable value
 @param aClass :class of passed value
 @return if value is present and conforms to class - returns Optional with it.
 Otherwise it returns Optional.empty
 */
+ (nonnull instancetype)ofNullable:(nullable SomeType const)aValue as:(nonnull Class)aClass;

/**
 If contained  value is dictionary it allows to access it's internals by key and returns Optional with value for it. If value isn't dictionary or it doesn't have value for key it returns Optional.empty;

 @param key :from dictionary
 @return Optional value with value for key or Optional.empty
 */
- (nonnull Optional *)objectForKeyedSubscript:(nonnull id<NSCopying>)key;


/**
 If contained value is array it allows to access it's internals by indx and returns Optional with value for it. If value isn't array it returns Optional.empty

 @param idx Index of element contained in value of Optional
 @return Optional with element for index in array
 */
- (nonnull Optional *)objectAtIndexedSubscript:(NSUInteger)idx;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;
@end

//This is needed for library optimization
#import <KAAOptional/Optional+Generic.h>
#import <KAAOptional/Optional+Convenience.h>
