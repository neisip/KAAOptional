//
//  Optional+Generic.m
//  KAAOptional
//
//  Created by Alex on 13/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "Optional+Private.h"

@implementation Optional (Generic)

- (Optional<id> *)orVal:(NS_NOESCAPE Optional<id> *(^const)(void))orValSupplier {
    if (self.hasValue) {
        return self;
    }
    NSParameterAssert(orValSupplier != nil);
    if (orValSupplier != nil) {
        return orValSupplier();
    }
    return Optional.empty;
}

- (id)orElse:(id)elseVal {
    NSParameterAssert(elseVal != nil);
    return self.hasValue ? self.value: elseVal;
}

- (id)orElseGet:(NS_NOESCAPE id (^_Nonnull const)(void))elseValSupplier {
    if (self.hasValue) {
        return self.value;
    }
    NSParameterAssert(elseValSupplier != nil);
    return elseValSupplier != nil ? elseValSupplier(): nil;
}

- (Optional *)map:(NS_NOESCAPE id (^const)(id _Nonnull))aMapAction {
    NSParameterAssert(aMapAction != nil);
    
    if (self.hasValue && aMapAction != nil) {
        return [self.class ofNullable:aMapAction(self.value)];
    }
    return [self.class empty];
}

- (Optional *)flatMap:(NS_NOESCAPE Optional *(^const)(id _Nonnull))aFlatMapAction {
    NSParameterAssert(aFlatMapAction != nil);
    
    if (self.hasValue && aFlatMapAction != nil) {
        Optional *res = aFlatMapAction(self.value);
        NSAssert([res isKindOfClass:Optional.class], @"Flatmap returned non-optional!");
        return res ?: Optional.empty;
    }
    return Optional.empty;
}

- (Optional *)filter:(NS_NOESCAPE BOOL (^const)(id _Nonnull))aFilterAction {
    
    NSParameterAssert(aFilterAction != nil);
    BOOL hasPassedTest = self.hasValue &&
    aFilterAction != nil &&
    aFilterAction(self.value);
    return hasPassedTest ? self : Optional.empty;
}

- (void)ifPresent:(NS_NOESCAPE void (^const)(id _Nonnull))anIfPresentAction {
    
    if (self.hasValue && anIfPresentAction != nil) {
        anIfPresentAction(self.value);
        return;
    }
}

- (void)ifPresent:(NS_NOESCAPE void (^const)(id _Nonnull))anIfPresentAction
           orElse:(NS_NOESCAPE dispatch_block_t)orElseAction {
    
    [self ifPresent:anIfPresentAction];
    
    if (orElseAction != nil) {
        orElseAction();
    }
}

@end
