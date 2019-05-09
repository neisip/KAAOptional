//
//  Optional+Convenience.m
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "Optional.h"
#import "Optional+Generic.h"

@implementation Optional (Convenience)

+ (Optional<id> *(^)(id _Nonnull))of {
    
    __weak typeof(self) welf = self;
    return ^Optional<id> *(id _Nonnull aValue) {
        __strong typeof(welf) strongSelf = welf;
        return [strongSelf of:aValue];
    };
}

+ (Optional<id> *(^)(id _Nonnull, Class  _Nonnull __unsafe_unretained))ofValueAs {
    
     __weak typeof(self) welf = self;
    return ^Optional<id> *(id _Nonnull aValue, Class _Nonnull klass) {
        __strong typeof(welf) strongSelf = welf;
        return [strongSelf of:aValue as:klass];
    };
}

+ (Optional<id> *(^)(id _Nonnull))ofNullable {
    
     __weak typeof(self) welf = self;
    return ^Optional<id> *(id _Nonnull aValue) {
        __strong typeof(welf) strongSelf = welf;
        return [strongSelf ofNullable:aValue];
    };
}

+ (Optional<id> *(^)(id _Nullable, Class  _Nonnull __unsafe_unretained))ofNullableAs {
    
     __weak typeof(self) welf = self;
    return ^Optional<id> *(id _Nonnull aValue, Class _Nonnull klass) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf ofNullable:aValue as:klass];
    };
}

- (Optional *(^)(NS_NOESCAPE Optional *(^const _Nonnull)(void)))orVal {
    
     __weak typeof(self) welf = self;
    return ^(NS_NOESCAPE Optional *(^const _Nonnull orValAction)(void)) {
        __strong typeof(welf) strongSelf = welf;
        return [strongSelf orVal:orValAction];
    };
}

- (id (^)(id  _Nonnull const))orElse {
    
    __weak typeof(self) welf = self;
    return ^(id _Nonnull const orElseAction) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf orElse:orElseAction];
    };
}

- (id (^)(NS_NOESCAPE id (^const _Nonnull)(void)))orElseGet {
    
    __weak typeof(self) welf = self;
    return ^(NS_NOESCAPE id (^const _Nonnull orElseGetAction)(void)) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf orElseGet:orElseGetAction];
    };
}


- (Optional *(^)(NS_NOESCAPE id (^const _Nonnull)(id _Nonnull)))map {
    
    __weak typeof(self) welf = self;
    
    return ^(NS_NOESCAPE id (^const _Nonnull aMapAction)(id _Nonnull)) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf map:aMapAction];
    };
}

- (Optional *(^)(NS_NOESCAPE Optional *(^const _Nonnull)(id _Nonnull)))flatMap {
    
    __weak typeof(self) welf = self;
    
    return ^(NS_NOESCAPE Optional *(^const _Nonnull aFlatMapAction)(id _Nonnull)) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf flatMap:aFlatMapAction];
    };
}

- (Optional *(^)(NS_NOESCAPE BOOL (^const _Nonnull)(id)))filter {
    
    __weak typeof(self) welf = self;
    
    return ^(NS_NOESCAPE BOOL (^const _Nonnull aFilterAction)(id _Nonnull)) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf filter:aFilterAction];
    };
}

- (void (^)(NS_NOESCAPE void (^const _Nonnull)(id _Nonnull)))ifPresent {
    
    __weak typeof(self) welf = self;
    
    return ^(NS_NOESCAPE void (^const _Nonnull ifPresentAction)(id _Nonnull)) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf ifPresent:ifPresentAction];
    };
}

- (void (^)(NS_NOESCAPE void (^const _Nullable)(id _Nonnull), NS_NOESCAPE dispatch_block_t _Nullable))ifPresentOrElse {
    
    __weak typeof(self) welf = self;
    
    return ^(NS_NOESCAPE void (^const _Nullable ifPresentAction)(id _Nonnull), NS_NOESCAPE dispatch_block_t _Nullable elseAction) {
        __strong typeof(welf) strongSelf = welf;
        
        return [strongSelf ifPresent:ifPresentAction orElse:elseAction];
    };
}

@end
