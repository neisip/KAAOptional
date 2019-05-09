//
//  NSArray+SafeOptional.h
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Optional.h"

@interface NSArray<__covariant ObjectType> (SafeOptional)

- (nonnull Optional<ObjectType> *)kaa_firstOptionalObjectPassingTest:(NS_NOESCAPE BOOL (^_Nonnull const)(const ObjectType _Nonnull aVal))testBlock __attribute__((pure));

@end
