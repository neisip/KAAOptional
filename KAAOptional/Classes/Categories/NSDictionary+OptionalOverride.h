//
//  NSDictionary+OptionalOverride.h
//  KAAOptional
//
//  Created by Alex on 14/04/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Optional.h"

@interface NSDictionary<__covariant KeyType, __covariant ObjectType> (OptionalOverride)


/**
 Will return Optional with object for Key or Optional empty if value doesn't exist.

 @param key Simple dictionary key
 @return Optional with value for key from dictionary or Optiona empty.
 */
- (nonnull Optional<ObjectType> *)objectForKeyedSubscript:(nonnull KeyType)key;

/**
 
 Warning! Enables optional return from dictionary for whole app!
 Old code won't crash, because of internal forwaring and won't cause bugs.
 But may cause your build fail, because of optional return.
 
 */
+ (void)kaa_enableOptionalByDefault;

@end
