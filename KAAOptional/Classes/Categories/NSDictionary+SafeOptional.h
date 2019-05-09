//
//  NSDictionary+SafeOptional.h
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Optional.h"

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (SafeOptional)
- (nonnull Optional<ObjectType> *)kaa_optionalForKey:(nonnull KeyType)aKey __attribute__((pure));
- (nonnull Optional<ObjectType> *)kaa_optionalForKey:(nonnull KeyType)aKey of:(nonnull Class)aClass __attribute__((pure));
- (nonnull Optional<ObjectType> *)kaa_firstOptionalKeyPassingTest:(NS_NOESCAPE BOOL (^_Nonnull const)(const KeyType _Nonnull aKey, const ObjectType _Nonnull aVal))testBlock __attribute__((pure));
@end
