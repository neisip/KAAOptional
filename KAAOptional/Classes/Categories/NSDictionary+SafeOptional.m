//
//  NSDictionary+SafeOptional.m
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "NSDictionary+SafeOptional.h"

@implementation NSDictionary (SafeOptional)

- (nonnull Optional *)kaa_optionalForKey:(nonnull id)aKey __attribute__((pure)) {
    NSParameterAssert(aKey != nil);
    return [Optional ofNullable:[self objectForKey:aKey]]; //used old sytax to prevent side effects
}

- (nonnull Optional *)kaa_optionalForKey:(nonnull id)aKey of:(nonnull Class)aClass __attribute__((pure)) {
    NSParameterAssert(aKey != nil && aClass != nil);
    
    id t = [self objectForKey:aKey];
    return [t isKindOfClass:aClass] ? [Optional of:t]: Optional.empty;
}

- (nonnull Optional *)kaa_firstOptionalKeyPassingTest:(NS_NOESCAPE BOOL (^_Nonnull const)(const id _Nonnull aKey, const id _Nonnull aVal))testBlock __attribute__((pure)) {
    NSParameterAssert(testBlock != nil);
    if (testBlock == nil) {
        return Optional.empty;
    }
    
    __block id foundElement = nil;
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (testBlock(key, obj)) {
            foundElement = key;
            *stop = YES;
        }
    }];
    
    return [Optional ofNullable:foundElement];
}
@end
