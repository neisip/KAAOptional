//
//  NSDictionary+OptionalOverride.m
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "NSDictionary+OptionalOverride.h"
#import <objc/runtime.h>

@implementation NSDictionary (OptionalOverride)

- (Optional *)objectForKeyedSubscript:(id)key {
    id obj = [self objectForKey:key];
    if (!shouldEnableOptionalByDefault) {
        return obj;
    }
    NSParameterAssert(key != nil);
    
    if ([obj isKindOfClass:[Optional class]]) {
        Optional *e = obj;
        return e.hasValue ? [Optional ofNullable:e.get]: Optional.empty;
    }
    return [Optional ofNullable:obj];
}

static BOOL shouldEnableOptionalByDefault = NO;

+ (void)kaa_enableOptionalByDefault {
    shouldEnableOptionalByDefault = YES;
}

@end
