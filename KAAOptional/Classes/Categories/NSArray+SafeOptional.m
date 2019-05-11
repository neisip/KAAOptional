//
//  NSArray+SafeOptional.m
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "NSArray+SafeOptional.h"

@implementation NSArray (SafeOptional)

- (Optional *)kaa_firstOptionalObjectPassingTest:(NS_NOESCAPE BOOL (^const)(id  _Nonnull const))testBlock {
    KAA_ASSERT_AND_RETURN_OPTIONAL(testBlock != nil)
    
    for (id e in self) {
        if (testBlock(e)) {
            return Optional.of(e);
        }
    }
    return Optional.empty;
}


@end
