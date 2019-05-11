//
//  NSObject+KAAComparator.m
//  KAAOptional
//
//  Created by Alex on 15/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "NSObject+KAAComparator.h"

@implementation NSObject (KAAComparator)

- (BOOL)kaa_isEqualTo:(nonnull id)aValue {
    if ([self isKindOfClass:NSArray.class]) {
        return [((NSArray *)self) isEqualToArray:aValue];
        
    } else if ([self isKindOfClass:NSAttributedString.class]) {
        return [((NSAttributedString *)self) isEqualToAttributedString:aValue];
        
    } else if ([self isKindOfClass:NSData.class]) {
        return [((NSData *)self) isEqualToData:aValue];
        
    } else if ([self isKindOfClass:NSDate.class]) {
        return [((NSDate *)self) isEqualToDate:aValue];
        
    } else if ([self isKindOfClass:NSDictionary.class]) {
        return [((NSDictionary *)self) isEqualToDictionary:aValue];
        
    } else if ([self isKindOfClass:NSHashTable.class]) {
        return [((NSHashTable *)self) isEqualToHashTable:aValue];
        
    } else if ([self isKindOfClass:NSIndexSet.class]) {
        return [((NSIndexSet *)self) isEqualToIndexSet:aValue];
        
    } else if ([self isKindOfClass:NSNumber.class]) {
        return [((NSNumber *)self) isEqualToNumber:aValue];
        
    } else if ([self isKindOfClass:NSOrderedSet.class]) {
        return [((NSOrderedSet *)self) isEqualToOrderedSet:aValue];
        
    } else if ([self isKindOfClass:NSSet.class]) {
        return [((NSSet *)self) isEqualToSet:aValue];
        
    } else if ([self isKindOfClass:NSString.class]) {
        return [((NSString *)self) isEqualToString:aValue];
        
    } else if ([self isKindOfClass:NSTimeZone.class]) {
        return [(NSTimeZone *)self isEqualToTimeZone:aValue];
        
    } else {
        return [self isEqual:aValue];
    }
}
@end
