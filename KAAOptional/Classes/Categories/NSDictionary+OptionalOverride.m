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

- (void)setKaa_shouldReturnOptional:(NSNumber *)kaa_shouldReturnOptional {
    objc_setAssociatedObject(self, @selector(kaa_shouldReturnOptional), kaa_shouldReturnOptional, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)kaa_shouldReturnOptional {
    return objc_getAssociatedObject(self, @selector(kaa_shouldReturnOptional));
}

- (instancetype)op {
    self.kaa_shouldReturnOptional = @(YES);
    return self;
}

- (Optional *)objectForKeyedSubscript:(id)key {
    id obj = [self objectForKey:key];
    BOOL isOptional = self.kaa_shouldReturnOptional.boolValue ||
    shouldEnableOptionalByDefault;
    if (!isOptional) {
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
