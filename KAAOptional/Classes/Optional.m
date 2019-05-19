//
//  Optional.m
//  KAAOptional
//
//  Created by Alex on 13/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "Optional.h"
#import "NSObject+KAAComparator.h"

@interface Optional ()
@property (nonatomic, nullable, readwrite) id value;
@end

@implementation Optional

#pragma mark - Constructors

+ (nonnull instancetype)empty {
    return [[self alloc] initWithValue:nil];
}

- (nonnull instancetype)initWithValue:(nullable const id)aValue {
    if (self = [super init]) {
        if ([aValue isKindOfClass:Optional.class]) {
            _value = ((Optional *)aValue).value;
        } else {
            _value = aValue;
        }
    }
    return self;
}

+ (nonnull instancetype)of:(nonnull const id)aValue {
    NSAssert(aValue != nil, @"Nonnull optional constructor recieved nil value");
    return [self ofNullable:aValue];
}

+ (nonnull instancetype)of:(nonnull const id)aValue as:(Class)aClass {
    NSAssert([aValue isKindOfClass:aClass], @"Passed to constructor optional value is not of the expected class: %@", NSStringFromClass(aClass));
    return [self of:aValue];
}

+ (nonnull instancetype)ofNullable:(nullable const id)aValue {
    return [[self alloc] initWithValue:aValue];
}

+ (nonnull instancetype)ofNullable:(id)aValue as:(Class)aClass {
    NSParameterAssert(aClass != nil);
    
    return [aValue isKindOfClass:aClass] ? [Optional ofNullable:aValue]:
    Optional.empty;
}

- (BOOL)hasValue {
    return self.value != nil;
}

- (BOOL)isEmpty {
    return !self.hasValue;
}

- (id)get {
    NSParameterAssert(self.value != nil);
    return self.value;
}

- (NSArray *)stream {
    return self.hasValue ? @[self.value] : @[];
}

- (Optional *)objectForKeyedSubscript:(id<NSCopying>)key {
    NSParameterAssert(key != nil);
    
    if ([self.value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *val = self.value;
        return [Optional ofNullable:val[key]];
    }
    return Optional.empty;
}

- (Optional *)objectAtIndexedSubscript:(NSUInteger)idx {
    
    if ([self.value isKindOfClass:[NSArray class]]) {
        NSArray *val = self.value;
        return [Optional ofNullable:val[idx]];
    }
    return Optional.empty;
}

#pragma mark - Equatable

- (BOOL)isEqual:(id)object {
    
    if (self == object) {
        return YES;
    }
    BOOL isAlsoOptional =  [object isKindOfClass:[self class]];
    BOOL hasSameClassAsValue = [object isKindOfClass:[self.value class]];
    
    BOOL isOfRightClass = isAlsoOptional || hasSameClassAsValue;
    if (!isOfRightClass) {
        return NO;
    }
    
    if (isAlsoOptional) {
        return [self isEqualToOptional:object];
    } else if (isOfRightClass) {
        return [self.value isEqual:object];
    } else {
        return NO;
    }
}

- (BOOL)isEqualToOptional:(Optional *)optional {
    
    BOOL haveValues = self.hasValue && optional.hasValue;
    
    if (haveValues) {
        return [self.value kaa_isEqualTo:optional.value];
    }
    
    return self.isEmpty && optional.isEmpty;
}

- (NSUInteger)hash {
    return [self.value hash];
}

#pragma mark - DevNull

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL slctr = [anInvocation selector];
    if ([self.value respondsToSelector:slctr]) {
        [anInvocation invokeWithTarget:self.value];
    } else if ([self respondsToSelector:slctr]) {
        [super forwardInvocation:anInvocation];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [self.value respondsToSelector:aSelector];
}

- (BOOL)isProxy {
    return YES; // Since we override isKindOfClass and isMember
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [self.value isKindOfClass:aClass] || [super isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [self.value isMemberOfClass:aClass] || [super isMemberOfClass:aClass];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature == nil) {
        if (self.value != nil) {
            signature = [self.value methodSignatureForSelector:aSelector];
        } else {
            signature = [super methodSignatureForSelector:@selector(devNull)];
        }
    }
    return signature;
}

- (void)devNull {
    
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[Optional allocWithZone:zone] initWithValue:self.value];
}

#pragma mark - Description

- (NSString *)description {
    return [NSString stringWithFormat:@"<Optional: %@, Value: %@>",
            [super description], self.value];
}

@end
